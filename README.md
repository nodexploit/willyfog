willyfog
========

End-of-degree project of [Adrian](https://github.com/soutoner) and 
[Nicolas](https://github.com/soasada). Willyfog is an ecosystem of 
different applications (web and mobile) that will try to simplify the 
process of setting equivalences between subjects of different 
universities around the world.

In particular this repository tries to centralize all the efforts to 
document this platform and its different parts and also, to provide a 
comfortable environment to both production and development stages of 
project the project with Docker and Vagrant.

> This was before the `play-scala` repository which purpose was to 
create friendly environment both for development and production stages 
of a Play for Scala app. To read more, please head [play-docker](docs/play-docker.md).

## Architecture

![Architecture](docs/architecture.png)

* (4) `willyfog-api`: REST API built with Scala on top of 
[Finagle](https://github.com/twitter/finagle) and 
[Finch](https://github.com/finagle/finch). This is the core of the project.
* (5) `willyfog-openid`: OpenID provider thanks to PHP, 
[Slim](https://github.com/slimphp/Slim) and 
[bshaffer/oauth2-server-php](https://github.com/bshaffer/oauth2-server-php).
* (3) `willyfog-web`: Web application of the project. PHP,  
[Slim](https://github.com/slimphp/Slim), we meet again.

[...]

To learn more, please head [projects/ README](projects/README.md).

## How does it work?

Thanks to awesome technologies like [Vagrant](https://www.vagrantup.com/) 
or [Docker](https://www.docker.com/), in a bunch of commands 
(and regardless of your operative system) you will have a complete development
environment.

If you follow the instructions, you won't have any problem to reproduce
the exact environment that we was supposed to use while developing.

What's more, the scripts that provision (i.e. install tools for the first time) 
the virtual machine that Vagrant creates are thought in such a way that
you can use them to bootstrap your own production VPS or bare-metal server.

In that way, you will have the same exact environment both in 
production and development stages (sounds good, isn't it?).

## Deploy

1. `git clone` the necessary repositories that conforms the project:

```
$ git clone https://github.com/popokis/willyfog-api.git projects/willyfog-api
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

## Access

If you use the default IP provided by the Vagrant machine i.e `192.168.33.10`
you will be able to access each application in the following ports:

* `willyfog-web`: 192.178.33.10:8000