CONSUL:
  docker run -d --name consul --net=app --restart always -p 8400:8400 -p 8500:8500 -p 53:53/udp -h node1 --net app consul -bootstrap -server -client 0.0.0.0 -ui-dir /ui
REGISTRATOR:
  docker run -d --net host --name=registrator --restart always --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest -internal consul://localhost:8500
NGINX-PROXY
  docker run --restart always -p 80:80 -d --name nginx_proxy --net=app nginx_proxy
