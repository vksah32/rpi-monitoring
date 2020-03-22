#!/bin/bash
cd prometheus
docker build -t prometheus-rpi .
docker run -p 9090:9090 --restart=always --name prometheus-rpi -d  prometheus-rpi
cd ..
