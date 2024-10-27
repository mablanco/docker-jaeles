# docker-jaeles

Docker image for Jaeles, a powerful, flexible and easily extensible framework written in Go for building your own Web Application Scanner (<https://jaeles-project.github.io/>). This is a multistage Docker image that first compiles the Golang source code and then builds an image from scratch that hosts the resulting executable.

## How to use this image

Before first use, Jaeles needs to initialize its configuration, plugins and signatures. In order to prevent downloading them each and every time you launch a container, a volume should be created to store all this data:

    docker volume create jaeles_config

Now it's time to initialize Jaeles:

    docker run -t --rm -v jaeles_config:/home/jaeles/.jaeles mablanco/jaeles config init -y

You can update signatures at a later date:

    docker run -t --rm -v jaeles_config:/home/jaeles/.jaeles mablanco/jaeles config update

I recommend running the Docker container with the `--rm` parameter when using Jaeles as a CLI tool, which will remove the container after finishing its execution.

This command will scan a website:

    docker run -t --rm -v jaeles_config:/home/jaeles/.jaeles mablanco/jaeles scan -u http://example.com

You can have a look at Jaeles' inline help like this:

    docker run --rm mablanco/jaeles

There are more usage examples at https://github.com/jaeles-project/jaeles#usage

## Web UI

You can start the Web UI, as a daemonized process, with the following command (note that we are giving the container a name and removing the `--rm` parameter):

    docker run -d -p 5000:5000 --name jaeles-server -v jaeles_config:/home/jaeles/.jaeles mablanco/jaeles server --host 0.0.0.0

Now the Web UI is accesible at http://127.0.0.1:5000/. The password to access the Web UI can be obtained executing this command:

    docker exec -it jaeles-server grep password /home/jaeles/.jaeles/config.yaml
