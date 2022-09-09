#!/bin/bash
sudo rm logs/appsec.log logs/defence.log
docker build -t c1-app-sec-uploader .

docker run -p 80:80 --rm \
  --name c1-app-sec-uploader \
  -e TREND_AP_KEY=$f0937a45-33c3-4e14-b619-5aeccb69ea6d \
  -e TREND_AP_SECRET=$831b316c-846f-48d4-a2c6-90d497e591b9 \
  -e TREND_AP_HELLO_URL='https://agents.us-1.application.cloudone.trendmicro.com' \
  -v $(pwd)/logs:/var/log/appsec:rw \
   c1-app-sec-uploader
