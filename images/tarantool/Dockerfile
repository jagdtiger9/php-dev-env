FROM tarantool/tarantool:2
MAINTAINER gimatov@gmail.com

# Expose ports
EXPOSE 3301

COPY app.lua /opt/tarantool
CMD ["tarantool", "/opt/tarantool/app.lua"]