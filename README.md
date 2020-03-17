# docker-jaeles

Docker image for Jaeles, a powerful, flexible and easily extensible framework written in Go for building your own Web Application Scanner (<https://jaeles-project.github.io/>). This is a multistage Docker image that first compiles the Golang source code and then builds an image from scratch that hosts the resulting executable.

## How to use this image

I recommend to run the Docker container with the `--rm` parameter, which will remove the container after finishing its execution, only if using Jaeles as a CLI tool that doesn't need to persist anything after running. In case you want to run Jaeles' API server, remove the `--rm` parameter and optionally add a Docker volume if you want persistance.

This command will run Jaeles with no parameters, thus showing its inline help:

    $ docker run --rm mablanco/jaeles

This command will scan a website:

    $ docker run -t --rm mablanco/jaeles scan -u http://example.com

This command will launch the API server at port 5000:

    $ docker run -d -p 5000:5000 --name jaeles-server mablanco/jaeles server --host 0.0.0.0

There are more usage examples at <https://github.com/jaeles-project/jaeles#usage>
