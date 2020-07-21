# Docker PHP-FPM 7.3 & Nginx 1.16 on Alpine Linux

## Usage

Copy your source code into `src/` directory.

### Build image

``` bash
docker build -t <your-image-name>:<tag> .
```

### Run image

expose port 9000 to host network.

``` bash
docker run -d -it -p 9000:8080 --name=<container-name> <your-image-name>:<tag>
```

### Remote into container

``` bash
docker exec -it <container-name> /bin/ash
```

### Destroy container

``` bash
docker stop <container-name>; docker rm <container-name>
```

### Curl test

``` bash
curl -I localhost:9000
```
