# docker-jdownloader2

Dockerfile to create and run your own jdownloader2 inside an alpine linux docker container.

## docker volumes

/var/jdownloader2/config

All jDownloader configuration files are stored here.

/var/jdownloader2/downloads

Downloads will be added here, you can change this setting via WebUI (my.jdownloader.org) or in the "org.jdownloader.settings.GeneralSettings.json" file.

## docker build
```shell
docker build -t YOURNAME/YOURCONTAINER:YOURTAG .
```
## docker run
```shell
docker run -d \
    -v /YOUR/PATH/downloads:/var/jdownloader2/downloads \
    -v /YOUR/PATH/config:/var/jdownloader2/config \
    --name jdownloader2 \
    11notes/jdownloader2:latest
```

## docker run (daemon with static ip and nfs plugin)
```shell
docker network create -d macvlan \
    --subnet=192.168.0.1/24 \
    --gateway=192.168.0.254 \
    -o parent=eth0 LAN

docker run -d \
    --network LAN \
    --ip 192.168.0.80 \
    --name jdownloader2 \
    --volume-driver=nfs \
    -v HOST/YOUR/PATH/downloads:/var/jdownloader2/downloads \
    -v HOST/YOUR/PATH/config:/var/jdownloader2/config \
    11notes/jdownloader2:latest
```

## my.jdownloader.org

Just create the file org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json in /var/jdownloader2/config with the following json settings:

```json
{
    "serverhost" : "api.jdownloader.org",
    "devicename" : "docker-11notes/jdownloader2:latest",
    "email" : "your@email.com",
    "password" : "password"
}
```

## build with

* [openjdk:8-jre-alpine](https://hub.docker.com/_/openjdk/) - alpine linux jre 8 image
* [jDownloader2](http://jdownloader.org/download/index) - jdownloader project
* [docker-volume-netshare](https://github.com/ContainX/docker-volume-netshare) - external filesystem plugin for docker volumes

## tips

* Limit RAM consumption with docker -m
* [alpine-docker-netshare](https://github.com/11notes/alpine-docker-netshare) - Examples to store downloads on NFS/CIFS/etc 



