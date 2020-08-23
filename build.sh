#!/bin/sh
docker build github.com/winffy2009/v2ray-docker
docker tag v2ray:latest winffy2009/v2ray:latest
docker push winffy2009/v2ray:latest
