# IMaaS

ImageMagick as a Service.

## How does it work

This repository contains two applications -- ImageMagic as a Service
http server and Convert as a Service client.

All you need is to deploy the server wherever you need and then
connect to it with the client the way you use `convert` util from
imagemagick. The only thing different is that you need to provide a
url to IMaaS via `CONVERTER_URL` environment variable.

## Building

To build the images you just need to run

```sh
docker-compose build
```
