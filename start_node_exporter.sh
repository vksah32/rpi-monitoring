#!/bin/bash

download_and_install_node_exporter () {
	curl -SL https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-armv7.tar.gz > node_exporter.tar.gz && \
	sudo tar -xvf node_exporter.tar.gz -C /usr/local/bin/ --strip-components=1
        return 0
}
# setup as a service
create_systemd_service_config_nodeexporter () {
        NODEEXPORTER_SERVICE_CONF_PATH='/etc/systemd/system/nodeexporter.service'
  	if [ -e $NODEEXPORTER_SERVICE_CONF_PATH ]; then
  	  echo "Nodexporter service already exists"
  	else
  	  #create service config file
          echo "Node exporter config doesn't exist, creating one"
          sudo touch $NODEEXPORTER_SERVICE_CONF_PATH
	  sudo cat <<EOF > $NODEEXPORTER_SERVICE_CONF_PATH
  	  [Unit]
  	  Description=NodeExporter

  	  [Service]
  	  TimeoutStartSec=0
  	  ExecStart=/usr/local/bin/node_exporter

  	  [Install]
  	  WantedBy=multi-user.target
EOF
  	fi
return 0
}


reload_and_start_systemd () {
	sudo systemctl daemon-reload \
	 && sudo systemctl enable nodeexporter \
	 && sudo systemctl start nodeexporter
}


if node_exporter --version ; then
   echo "Node exporter already exists"
else
  download_and_install_node_exporter
  if [ $? -eq 0 ]; then
     echo "Successfully downloaded and installed"
  else
     echo "Failed during install"
     exit 1
  fi
fi

create_systemd_service_config_nodeexporter
if [ $? -eq 0 ]; then
	echo "Successfully created systemd serviuce conf"
else
    echo "Failed during creating systemd conf"
    exit 1
fi

reload_and_start_systemd
if [ $? -eq 0 ]; then
	echo "Successfully restarted systemd"
else
	echo "Failed during systemd restart"
	exit 1
fi
