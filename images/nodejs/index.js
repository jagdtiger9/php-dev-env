var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var redis = require("redis"),
    subscriber = redis.createClient("6379", "redis"),
    publisher  = redis.createClient("6379", "redis");

//название канала в редис
subscriber.subscribe("nodeChannel");

//пример публикации в канал со стороны nodejs
publisher.publish("nodeChannel", "test publish from nodejs");

//подписываемся на событие сообщения от редис
subscriber.on("message", function(channel, message) {
    console.log("Message '" + message + "' on channel '" + channel + "' arrived!");
    //генерируем событие для клиента
    io.emit('chat message', message);
});

//запускаем сервер
http.listen(8085, function(){
    console.log('listening on *:8085');
});