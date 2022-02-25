# Cloud One Application Security with PHP Uploader

This demo app for Cloud One Application Security create an Apache PHP based front end allowing to upload kind of files. It is to simulate file uploading capabilities from real world web applications.

Application Security integration done via the provided Dockerfile.

## Usage

First, clone the repo

```sh
git clone https://github.com/mawinkler/c1-app-sec-uploader.git
```

Now, set your Application Security keys

```sh
# YOUR KEYS HERE
export APPSEC_KEY=<your key>
export APPSEC_SECRET=<your secret>
export C1_REGION=<your cloud one region>

# YOUR DOCKER HUB USERNAME (required for deploy.sh only)
export DOCKER_USERNAME=<your username>
```

Eventually, if your Cloud One V2 account is NOT running in `us-1` you need to adapt the hello_url in the `trend_app_protect.ini`.

Then build and run the container, which you can do by running

```sh
# Run app on your local docker engine
./run.sh

# Deploy app with a loadbalancer service on your current kubernetes context
./deploy.sh
```

The upload app is accessible on port 80.

Finally, upload malicious files.

## Test

```sh
curl -H "User-Agent: () { :; }; /bin/eject" http://127.0.0.1:80
```

## Support

This is an Open Source community project. Project contributors may be able to help, depending on their time and availability. Please be specific about what you're trying to do, your system, and steps to reproduce the problem.

For bug reports or feature requests, please [open an issue](../../issues). You are welcome to [contribute](#contribute).

Official support from Trend Micro is not available. Individual contributors may be Trend Micro employees, but are not official support.

## Contribute

I do accept contributions from the community. To submit changes:

1. Fork this repository.
1. Create a new feature branch.
1. Make your changes.
1. Submit a pull request with an explanation of your changes or additions.

I will review and work with you to release the code.
