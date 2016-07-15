projects
========

Here are located the different repositories that conforms project Willyfog:

![Architecture](../docs/architecture.png)

* (4) `willyfog`: REST API built with Scala on top of [Finagle](https://github.com/twitter/finagle) and [Finch](https://github.com/finagle/finch). This is the core of the project.
* (5) `willyfog-openid`: OpenID provider thanks to PHP, [Slim](https://github.com/slimphp/Slim) and [bshaffer/oauth2-server-php](https://github.com/bshaffer/oauth2-server-php).
* (3) `willyfog-web`: Web application of the project. PHP,  [Slim](https://github.com/slimphp/Slim), we meet again.

```
git clone https://github.com/popokis/willyfog.git           # API (core)
git clone https://github.com/popokis/willyfog-openid.git    # OpenID provider
git clone https://github.com/popokis/willyfog-web.git       # Web app
```