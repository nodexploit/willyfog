# play-docker

A project for development and production environment of Play for Scala with Docker and Vagrant.

```
                                              debian
                                           +----------+        XXXXXXXXXXXXXXXXX
                                           |          |        X               X
                                           |   SRC    +-------->  PERSISTENCE  <---+
                                           |          |        X               X   |
                                           +----+-----+        XXXXXXXXXXXXXXXXX   |
                                                |                   debian         |
                                                |                                  |
                                                |                                  |
                                                |                                  |
                                                |                                  |
XXXXXXXX            +------------+         +----v-----+      +-----------+     +---+----+
X      X            |            |         |          |      |           |     |        |
X USER +------------>   APACHE   +-------->+   JAVA   +------>   MySQL   +----->  DATA  |
X      X            |            |         |          |      |           |     |        |
XXXXXXXX            +------------+         +----------+      +-----------+     +--------+
                        httpd                 debian            mysql            debian

                                                X
                                                X
                                                X

                                         MORE JAVA DOCKERS

```
<p align="center">
  **Diagram of containers**
</p>
