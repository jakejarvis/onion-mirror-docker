# onion-mirror-docker

**🚧 Work in progress!**

## Start automatically

```
# /lib/systemd/system/onion-mirror.service

[Unit]
Description=Tor hidden service
Requires=docker.service
After=docker.service network.target

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/opt/onion-mirror-docker
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

## License

MIT
