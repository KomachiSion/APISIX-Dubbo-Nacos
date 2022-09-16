# APISIX-Dubbo-Nacos
APISIX-Dubbo-Nacos Demo

在使用此demo前，需要安装 [Docker](https://www.docker.com/) 和 [Docker Compose](https://docs.docker.com/compose/) ；并确保有java运行环境。

## 启动APISIX以及Nacos

```shell script
    git clone https://github.com/KomachiSion/APISIX-Dubbo-Nacos.git
    cd APISIX-Dubbo-Nacos/demo/docker
    docker-compose -p docker-apisix-dubbo-nacos up -d
```

等待所有容器启动后，通过telnet或curl命令检查：

```shell script
    telnet 127.0.0.1 9080
    telnet 127.0.0.1 8848
```

## 启动 dubbo 样例

```shell script
    cd APISIX-Dubbo-Nacos/demo/dubbo-samples-nacos-registry-1.0
    bin/startup.sh
    tail -f logs/stdout.log
```

等待 `dubbo service started` 字样出现。

浏览器登陆Nacos控制台 `127.0.0.1:8848/nacos` 默认用户名密码为`nacos, nacos`

可以看到dubbo服务已经注册到nacos中。

## APISIX 设置 upstream及route规则

```shell script
curl http://127.0.0.1:9080/apisix/admin/routes/1 -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -i -d '
{
    "uri": "/dubbo/nacos",
    "upstream": {
        "service_name": "providers:org.apache.dubbo.samples.api.ApisixService:1.0.0:",
        "type": "roundrobin",
        "discovery_type": "nacos"
    },
    "plugins": {
        "dubbo-proxy": {
            "service_name": "org.apache.dubbo.samples.api.ApisixService",
            "service_version": "1.0.0",
            "method": "apisixDubbo"
        }
    }
}'
```

返回 `HTTP/1.1 201 Created` 则证明创建成功

同时可以用 `curl http://127.0.0.1:9080/apisix/admin/routes/1 -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1'`  查看该规则。

## 通过APISIX 调用dubbo服务

使用`curl -v http://127.0.0.1:9080/dubbo/nacos  -H "Host: example.org"  -X POST --data '{"name": "hello"}'` 进行测试调用，
返回`dubbo success` 即为调用成功。

同时可以在 dubbo样例的日志`logs/stdout.log` 中看到打印出来的http headers和内容参数。
