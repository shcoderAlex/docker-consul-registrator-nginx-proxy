#!/bin/bash
nginx
consul-template -consul=$CONSUL_URL -template="/templates/service.ctmpl:/etc/nginx/conf.d/service.conf:nginx -s reload"
