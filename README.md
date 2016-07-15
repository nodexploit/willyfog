willyfog-devops
===============

A project for development and production environment of project Willyfog with Docker and Vagrant.

This was before the `play-scala` repository which purpose was to create friendly environment both for development and production stages 
of a Play for Scala app. To read more, please head here [play-docker](docs/play-docker.md).

## Architecture

![Architecture](docs/architecture.png)

To learn more, please head [projects/ README](projects/README.md).

## Deploy

1. `git clone` the necessary repositories that conforms the project:

```
$ git clone https://github.com/popokis/willyfog.git projects/willyfog
$ git clone https://github.com/popokis/willyfog-openid.git projects/willyfog-openid
$ git clone https://github.com/popokis/willyfog-web.git projects/willyfog-web
```

2. Do the vagrant!

```
$ vagrant up
[...]
$ vagrant ssh
[...]
```

3. Head to the following READMEs:

* [willyfog](https://github.com/popokis/willyfog/blob/master/README.md#deploy)
* [willyfog-openid](https://github.com/popokis/willyfog-openid/blob/master/README.md#deploy)
* [willyfog-web](https://github.com/popokis/willyfog-web/blob/master/README.md#deploy)

To see particular details of the deploy of those projects.