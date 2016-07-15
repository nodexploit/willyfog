willyfog-devops
===============

A project for development and production environment of project Willyfog with Docker and Vagrant.

This was before the `play-scala` repository.

(!!) From here README will change. Showing the ol' good one.

## Philosophy

The main purpose of this repository is to create friendly environment both for development and production stages
of a Play for Scala app.

The philosophy is to have exactly the same production environment when you're developing (except for environment
variables of course).

Thanks to [Vagrant](https://www.vagrantup.com/) we will fake our VPS environment while we are developing. The scripts that provisions the
virtual machine should be as close as possible as the one used to provision your production VPS.

In production, all our environment will be boosted by [Docker](https://www.docker.com/) starting as many containers as
we need to isolate the different components of our application.

### Production-oriented

The reason behind this is to follow a **production-oriented** approach. If we ensure that our development environment is
exactly the same as the production one, we minimize the risk of moving our code into production. In conjunction with some
CI tool as [Jenkins](https://jenkins.io/), we aim to build an spotless workflow for little projects.

Ideally, we should have a VPS (or other kind of hosting) with lots of *docker* containers like this:

```
    Production VPS
+-----------------------------+
|                             |
|                             |
|   +----+        +----+      |
|   |    +--------+    |      |
|   ++---+        +-+--+      |
|    |              |         |
|    |  +----+      |         |
|    +---|   +------+         |
|       +----+                |
|                             |
|          Docker Containers  |
+-----------------------------+

```

[...]

To read more, please head here [play-docker](docs/play-docker.md).