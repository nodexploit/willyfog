# play-docker

A project for development and production environment of Play for Scala with Docker and Vagrant.

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

If we encapsulate that VPS (that in the end is a virtual machine running somewhere) into a *Vagrant* machine inside our
host system, we reach our ideal development environment:

```
  Development Vagrant machine
+-----------------------------------+
|                                   |
|      Production VPS               |
|  +-----------------------------+  |
|  |                             |  |
|  |                             |  |
|  |   +----+        +----+      |  |
|  |   |    +--------+    |      |  |
|  |   ++---+        +-+--+      |  |
|  |    |              |         |  |
|  |    |  +----+      |         |  |
|  |    +---|   +------+         |  |
|  |       +----+                |  |
|  |                             |  |
|  |          Docker Containers  |  |
|  +-----------------------------+  |
|                                   |
+-----------------------------------+

```

## Play with Docker

In order to understand why we have chosen the following containers schema, we need
to fully understand how works a deploy of a Play app, as it can be a little different from
the ones of PHP, Python, etc.

### Deploying a Play app

When you have your awesome Play app ready to move into production-beast-mode, you won't have to
struggle with application servers such as Tomcat or Wildfly. How is this possible?

Thanks to **activator's** `dist` action, Play will build a binary version of your app,
so you can deploy it to your VPS without any dependency on *SBT* or *Activator*.Almost, the only
thing that your server needs is Java installed on it.

Of course you will need some HTTP server such as *Apache* or *Nginx*, that will handle your incoming requests
and will delegate them to the Play app.

That's all.

Really.

> More on this on the [official documentation](https://www.playframework.com/documentation/2.5.x/Deploying).

Once that we have a wider idea of how a Play deployments looks like, we only have to *dockerize* it.

Here is a diagram of what we think is a good *Docker* environment for a Play app. We try to isolate as many components
as possible.

```
                              +--------   Play Application   --------+
                              |                                      |
                              |                                      |
                              |                debian                |
                                            +----------+
                                            |          |
                                        +---+   SRC    +------------------------+
                                        |   |          |                        |
                                        |   +----------+                        |
                                        |                                       |
                                        |                                       |
                                        |                                       |
XXXXXXXX      +------------+       +----v-----+      +-----------+      XXXXXXXXXXXXXXXXX
X      X      |            |       |          |      |           |      X               X
X USER +------>   APACHE   +------>+   JAVA   +------>   MySQL   |      X  PERSISTENCE  X
X      X      |            |       |          |      |           |      X               X
XXXXXXXX      +------------+       +----------+      +-----------+      XXXXXXXXXXXXXXXXX
                  httpd               debian            mysql                debian
                                        |                 |                     |
                                        +--------+--------+                     |
                                                 |                              |
                                             +---+----+                         |
                                             |        |                         |
                                             |  DATA  +-------------------------+
                                             |        |
                                             +--------+
                              |                debian                |
                              |                                      |
                              |                                      |
                              +--------------------------------------+
```

* **Apache**: it will act as the doorkeeper of our app, handling incoming request of the user and delegating them to the
binary version of the application.
* **Java**: we have a container that simply runs our application.
* **MySQL**: an instance that will serve our database.
* **Persistence**: think of it as a concept. Actually, this is the filesystem of our VPS, and is the only part of the ecosystem
that persists during the life cycle of the containers.

As you can see there're two more modules in this diagram. They are [data volumes](https://docs.docker.com/engine/userguide/containers/dockervolumes/)
so let's explain them more in detail:

* **Src**: it will serve the code (binary version) of our app. With this, we abstract the persistence from the
*Docker* ecosystem. if we have more than one application or we want to instantiate more than one *Java* container, we ensure
that all of them will read from an unified place.
* **Data**: the *Java* container an the *MySQL* should persist during the life cycle of our application. Once again
what we are doing is to unify the persistence parts of our application into the same point so we have more control
of the critical part of the application, that is the one that saves and gets the data from the VPS file system.

Of course, everything that hangs from the *Apache* container and that connects with the persistence module can be replicated
as many times as necessary if you want to have more than one Play application.

```
                                    +-----------------+
                                    |                 |
                                    |                 |
                                +---+    Play App 1   +---------------+
                                |   |                 |               |
                                |   |                 |               |
                                |   +-----------------+               |
                                |                                     |
                                |                                     |
                                |   +-----------------+               |
XXXXXXXX      +------------+    |   |                 |       XXXXXXXXXXXXXXXXX
X      X      |            |    |   |                 |       X               X
X USER +------>   APACHE   +--------+    Play App 2   +-------X  PERSISTENCE  X
X      X      |            |    |   |                 |       X               X
XXXXXXXX      +------------+    |   |                 |       XXXXXXXXXXXXXXXXX
                  httpd         |   +-----------------+            debian
                                |                                     |
                                |                                     |
                                |   +-----------------+               |
                                |   |                 |               |
                                |   |                 |               |
                                +---+    Play App 3   +---------------+
                                    |                 |
                                    |                 |
                                    +-----------------+
```

Or maybe you want a *more performing* approach to an individual Play application:

```
                              +--------   Play Application   --------+
                              |                                      |
                              |         X               debian       |
                                        X            +----------+
                                        X            |          |
                                                     |   SRC    +---------------+
                                   +----------+      |          |               |
                                   |          |      +----------+               |
                               +----+  JAVA   +---+                             |
                               |   |          |   |                             |
                               |   +----------+   |                             |
                               |                  |                             |
                               |      debian      |                             |
XXXXXXXX      +------------+   |   +----------+   |  +-----------+      XXXXXXXXXXXXXXXXX
X      X      |            |   |   |          |   |  |           |      X               X
X USER +------>   APACHE   +------>+   JAVA   +------>   MySQL   |      X  PERSISTENCE  X
X      X      |            |   |   |          |   |  |           |      X               X
XXXXXXXX      +------------+   |   +----------+   |  +-----------+      XXXXXXXXXXXXXXXXX
                  httpd        |      debian      |     mysql                debian
                               |                  |        +                    |
                               |   +----------+   |        |                    |
                               |   |          |   |        |                    |
                               +---+   JAVA   +---+        |                    |
                                   |          |        +---+----+               |
                                   +----------+        |        |               |
                                      debian           |  DATA  +---------------+
                                                       |        |
                                        X              +--------+
                              |         X                debian      |
                              |         X                            |
                              |                                      |
                              +--------------------------------------+

```

Note: of course, all Java instances are connected to both *Src* and *Data* modules, but I haven't drawn the different connections
so the diagram remains clear.

## Requirements

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

