# rpi-monitoring
Monitoring rpi using prometheus 

This repo contains scripts and docker config to set up monitoring for my raspberry pi cluster.

The basic idea is start node_exporter on each machine, start prometheus on master, start grafana on master.

Prometheus scrapers metrics from each `node_exporter` that grafana will show.

To add prometheus source, use `http://10.0.0.1:9090` and use dashboard id: `1860`
