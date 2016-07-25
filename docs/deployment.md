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

1. Install dependencies:
```
$ cd ~/willyfog/projects/willyfog-api
$ composer install
```
2. Set the `constants.php` file. If it's not production, you can simply 
rename `constants.php.example` to `constants.php`. 
```
$ mv app/constants.php.example app/constants.php
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
$ mv app/constants.php.example app/constants.php
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
$ mv app/constants.php.example app/constants.php
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