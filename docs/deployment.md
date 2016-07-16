deployment
==========

Let's start!

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

## willyfog-api

### Connecting to the database

In order to connect to the database you may find yourself in this two cases:

* Maybe you're deploying the API making a `jar` (with something like 
[sbt-assembly](https://github.com/sbt/sbt-assembly)) and running it with 
`java` **inside the Vagrant environment**. In this case you will have
the MySQL server locally so you **don't have to hesitate to connect**.
* But, if you're executing your `jar` from **outside the Vagrant environment**
(because you're badass!) or more probably, you're developing with some
IDE like **IntelliJ** which takes care of deploying the `jar` by itself, you
will find yourself in troubles because **you won't have the MySQL server locally**.

### Creating a SSH tunnel

Don't panic! Let's make an ssh tunnel so you can connect the database server
like a charm. Please execute this command:

```
# (From the host machine)
$ ssh -f vagrant@192.168.33.10 -L 3307:localhost:3306 -N
```

So from here on, you will have the database server listening locally on `3307`. 
If you want to connect via MySQL cli, you only have to execute:

```
# (From the host machine)
$ mysql -h 127.0.0.1 -P 3307 -uroot -proot
```

### Everything is in the jar

Because it's deadly simple, we use 
[sbt-assembly](https://github.com/sbt/sbt-assembly) to build our `jar`.

```
$ cd ~/willyfog/project/willyfog-api
$ sbt
[...]
> assembly
[...]
[info]   Compilation completed in XX.XXX s
> exit
```

And after all is finished, you will have your brand new `jar` under
`project/target/scala-2.11/willyfog-assembly-1.0.jar`, so you can deploy the app in background with:

```
java -jar project/target/scala-2.11/willyfog-assembly-1.0.jar &
```

## willyfog-openid

1. Install dependencies:
```
$ cd ~/willyfog/projects/willyfog-openid
$ composer install
```

2. Generate public and private keys:
```
$ openssl genrsa -out data/privkey.pem 4096
$ openssl rsa -in data/privkey.pem -pubout -out data/pubkey.pem
```

## willyfog-web

1. Install dependencies:
```
$ cd ~/willyfog/projects/willyfog-web
$ composer install
```

And that's all folks!