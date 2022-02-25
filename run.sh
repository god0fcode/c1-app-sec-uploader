#!/bin/bash
sudo rm logs/appsec.log logs/defence.log
docker build -t c1-app-sec-uploader .

docker run -p 80:80 --rm \
  --name c1-app-sec-uploader \
  -e TREND_AP_KEY=${APPSEC_KEY} \
  -e TREND_AP_SECRET=${APPSEC_SECRET} \
  -e TREND_AP_HELLO_URL='https://agents.'${C1_REGION}'.application.cloudone.trendmicro.com' \
  -v $(pwd)/logs:/var/log/appsec:rw \
   c1-app-sec-uploader
