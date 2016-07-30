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

### Using sbt dist

Because it's deadly simple, we use 
`sbt dist` to build our executable.

```
$ cd ~/willyfog/project/willyfog-api
$ sbt
[...]
> dist
[...]
[success] Total time: XXXX s, completed Xxx XX, XXXX X:XX:XX PM
> exit
```

And after all is finished, you will have your brand new `zip` under
`target/universal/willyfog-api-1.0.zip`. Unzip it:

```
$ cd target/universal/willyfog-api-1.0
$ unzip willyfog-api-1.0.zip
$ cd willyfog-api-1.0
```

And then execute it with your application secret:

```
$ bin/willyfog-api -Dplay.crypto.secret=abcdefghijk
```

## willyfog-openid

1. Install dependencies:
```
$ cd ~/willyfog/projects/willyfog-openid
$ composer install
```
2. Set the `constants.php` file. If it's not production, you can simply 
rename `constants.php.example` to `constants.php`. 
```
$ cp app/constants.php.example app/constants.php
```
3. Generate public and private keys:
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
2. Set the `constants.php` file. If it's not production, you can simply 
rename `constants.php.example` to `constants.php`. 
```
$ cp app/constants.php.example app/constants.php
```
3. Link `openid` server public key (in order to handle JWT)
```
$ cd data
$ ln -s ../../willyfog-openid/data/pubkey.pem
```

## Domains

Remember to add the different domains to your `/etc/hosts` file:
```
$ echo "192.168.33.10  willyfog.com api.willyfog.com openid.willyfog.com" | sudo tee -a /etc/hosts
```


And that's all folks!