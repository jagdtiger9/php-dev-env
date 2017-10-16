// подключенные нативные клиенты
var webSocketClients = {};
// socket.io клиенты
var socketIOclients = {};

var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var WebSocketServer = require('ws');
var redis = require("redis")
    , subscriber = redis.createClient("6379", "localhost")
    , publisher  = redis.createClient("6379", "localhost");

//start websockets server
var webSocketServer = new WebSocketServer.Server({port: 8889});

//websockets connection
webSocketServer.on('connection', function(ws) {
    let random = getRandomId(webSocketClients);
    ws.random_id = random;
    webSocketClients[random] = ws;
    console.log("соединение открыто webSocketClients. Общее количество " + Object.keys(webSocketClients).length);
    ws.on('close', function(ws) {
        for (let sock in webSocketClients) {
            console.log(sock);
            console.log(this.random_id);
            if (sock == this.random_id) {
                delete webSocketClients[sock];
            }
        }
        console.log("соединение закрыто webSocketClients. Общее количество " + Object.keys(webSocketClients).length);
    });
});

//socket.io connection
io.sockets.on('connection', function (socket) {
    socketIOclients[socket.id] = socket;
    console.log("новое соединение socketIOclients. Общее количество " + Object.keys(socketIOclients).length);
    socket.on('disconnect', function () {
        for (let sock in socketIOclients) {
            if (socketIOclients[sock] === socket) {
                delete socketIOclients[sock];
            }
        }
        console.log("соединение закрыто socketIOclients. Общее количество " + Object.keys(socketIOclients).length);
    });
});



app.get('/', function(req, res){
    res.sendFile(__dirname + '/index.html');
});


//название канала в редис
subscriber.subscribe("datatube");

//подписываемся на событие сообщения от редис
subscriber.on("message", function(channel, message) {
    console.log("Message '" + message + "' on channel '" + channel + "' arrived!");
    //генерируем событие для клиента
    io.sockets.emit('channeldata', {data: message});

    setTimeout(function () {
        for(var key in webSocketClients) {
            webSocketClients[key].send(message);
        }
    }, 1000);
});



//запускаем сервер для socket.io
var port = process.argv[2] || 8888;
http.listen(port, function(){
    console.log('listening on *:' + port);
});

//helper
function getRandomId(webSocketClients) {
    let random = Math.random()*10000000000000000;
    if (webSocketClients[random]) {
        getRandomId(webSocketClients);
    } else {
        return random;
    }
}



