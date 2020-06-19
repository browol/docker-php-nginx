# Docker PHP-FPM 7.3 & Nginx 1.16 on Alpine Linux

## Usage

Copy your source code into `src/` directory.

### Build image

``` bash
docker build -t kittipol/phpfpm-nginx:release-v1.0 .
```

### Run image

expose port 9000 to host network.

``` bash
docker run -d -it -p 9000:8080 --name=phprelease kittipol/phpfpm-nginx:release-v1.0
```

### Remote into container

``` bash
docker exec -it phprelease /bin/ash
```

### Destroy container

``` bash
docker stop phprelease; docker rm phprelease
```

### Curl test

``` bash
curl -I localhost:9000
```
