#!/bin/bash
docker login
docker build -t c1-app-sec-uploader .
docker tag c1-app-sec-uploader ${DOCKER_USERNAME}/c1-app-sec-uploader:latest
docker push ${DOCKER_USERNAME}/c1-app-sec-uploader:latest

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
  name: c1-app-sec-uploader
  labels:
    app: c1-app-sec-uploader
spec:
  type: LoadBalancer
  ports:
  - port: 80
    name: c1-app-sec-uploader
    targetPort: 80
  selector:
    app: c1-app-sec-uploader
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: c1-app-sec-uploader
  name: c1-app-sec-uploader
spec:
  replicas: 1
  selector:
    matchLabels:
      app: c1-app-sec-uploader
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  template:
    metadata:
      labels:
        app: c1-app-sec-uploader
    spec:
      containers:
      - name: c1-app-sec-uploader
        image: ${DOCKER_USERNAME}/c1-app-sec-uploader:latest
        imagePullPolicy: Always
        env:
        - name: TREND_AP_KEY
          value: ${APPSEC_KEY}
        - name: TREND_AP_SECRET
          value: ${APPSEC_SECRET}
        - name: TREND_AP_HELLO_URL
          value: https://agents.${C1_REGION}.application.cloudone.trendmicro.com
        ports:
        - containerPort: 80
EOF
