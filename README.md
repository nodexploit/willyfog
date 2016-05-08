# play-docker

```
                                              debian
                                           +----------+                                     XXXXXXXXXXXXXXXXX
                                           |          |                                     X               X
                                           |   SRC    +------------------------------------->  PERSISTENCE  X
                                           |          |                                     X               X
                                           +----+-----+                                     XXXXXXXXXXX^XXXXX
                                                |                                                      |
                                                |                                                      |
                                                |                                                      |
                                                |                                                      |
                                                |                                                      |
XXXXXXXX            +------------+         +----v-----+               +-----------+               +----+-----+
X      X            |            |         |          |               |           |               |          |
X USER +------------>   APACHE   +-------->+   JAVA   +--------------->   MySQL   +--------------->   DATA   |
X      X            |            |         |          |               |           |               |          |
XXXXXXXX            +------------+         +----------+               +-----------+               +----------+
                        httpd                 debian                      mysql                      debian

                                                X
                                                X
                                                X

                                         MORE JAVA DOCKERS

```
