# Docker PHP-FPM 5.6 & Nginx 1.16 on Alpine Linux
Example PHP-FPM 5.6 & Nginx 1.16 setup for Docker, build on [Alpine Linux](http://www.alpinelinux.org/).

![nginx 1.16.1](https://img.shields.io/badge/nginx-1.16-brightgreen.svg)
![php 5.6](https://img.shields.io/badge/php-5.6-brightgreen.svg)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## Usage

For example, We'll create Laravel version 5.2

    cd /Users/demo-docker && \
    composer create-project --prefer-dist laravel/laravel src "5.2.*"

Build Docker Image

    docker build -t laravel-56:v1 .


Start the Docker container:

    docker run -d -v $(pwd)/src:/var/www/html/ -p 5000:8080 --name=laravel56 laravel-56:v1

See our Laravel website http://0.0.0.0:5000

## License

The Laravel framework is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).

