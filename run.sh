#!/bin/bash
sudo rm logs/appsec.log logs/defence.log
docker build -t c1-app-sec-uploader .

docker run -p 80:80 --rm \
  --name c1-app-sec-uploader \
  -e TREND_AP_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXX\
  -e TREND_AP_SECRET=XXXXXXXXXXXXXXXXXXXXXXXX \
  -e TREND_AP_HELLO_URL='https://agents.us-1.application.cloudone.trendmicro.com' \
  -v $(pwd)/logs:/var/log/appsec:rw \
   c1-app-sec-uploader
