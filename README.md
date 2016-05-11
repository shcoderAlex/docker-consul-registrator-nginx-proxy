version: '2'
services:
  consul:
    image: shcoder/consul
    container_name: consul
    restart: always
    ports:
      - 8400:8400
      - 8500:8500
      - 53:53/udp
    entrypoint:
      - /bin/start
      - -bootstrap
      - -server
      - -client 0.0.0.0

  registrator:
    image: gliderlabs/registrator
    container_name: registrator
    restart: always
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock
    entrypoint:
      - /bin/registrator
      - -internal
      - consul://consul:8500
    links:
      - consul

  proxy:
    image: shcoder/nginx-proxy-consul-template
    container_name: nginx_proxy
    ports:
      - 80:80
    volumes:
      - ${PWD}/templates:/templates
    links:
      - consul
      - registrator
    environment:
      - CONSUL_URL=consul:8500
      - SERVICE_80_NAME=nginx_proxy

networks:
  default:
    external:
      name: app