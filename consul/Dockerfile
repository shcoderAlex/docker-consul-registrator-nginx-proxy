FROM 		progrium/busybox
MAINTAINER 	Jeff Lindsay <progrium@gmail.com>

ADD https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip /tmp/webui.zip
RUN mkdir /ui && cd /tmp && unzip /tmp/webui.zip -d /ui && rm /tmp/webui.zip

ADD https://get.docker.io/builds/Linux/x86_64/docker-1.2.0 /bin/docker
RUN chmod +x /bin/docker

RUN opkg-install curl bash

ADD ./config /config/
ONBUILD ADD ./config /config/

ADD ./start /bin/start
ADD ./check-http /bin/check-http
ADD ./check-cmd /bin/check-cmd

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp
VOLUME ["/data"]

ENV SHELL /bin/bash

ENTRYPOINT ["/bin/start"]
CMD []
