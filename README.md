ComiGuide
-----
ComicMarket & COMIC1 participants support site.

Ruby version
-----
2.1.2 (rbenv)

Ruby on Rails version
-----
4.1.5

System dependencies
-----
* Ubuntu 14.04 LTS
* ruby
* bundler
* MySQL

Configuration
-----

Database creation
-----

```
$ bundle exec rake db:setup
```

Database initialization
-----

```
$ bundle exec rake db:migrate
$ bundle exec rake create_data:all
```

How to run the test suite
-----

Services (job queues, cache servers, search engines, etc.)
-----

Deployment instructions
-----
**shared_files**

```
shared
  - .env
  - database.yml
```

**dotenv**

* SECRET_KEY_BASE

**database.yml**

```yml
production:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: comiguide_production
  pool: 5
  username: root
  password: password
  socket: /var/run/mysqld/mysqld.sock
```

**deploy commands**

* `bundle exec cap production deploy`
* `bundle exec cap production unicorn:stop`

**Nginx**

```
server {
    listen 443 ssl;
    server_name comiguide.net;

    keepalive_timeout 5;

    # Location of our static files
    root /var/www/apps/comiguide/current/public;

    ssl_certificate      /etc/nginx/certs/comiguide.startssl.crt;
    ssl_certificate_key  /etc/nginx/certs/comiguide.startssl.key;
    ssl_session_timeout  5m;
    ssl_protocols  SSLv3 TLSv1;
    ssl_ciphers  RC4-SHA:HIGH:!ADH;
    ssl_prefer_server_ciphers   on;

    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-FORWARDED_PROTO https;
        proxy_set_header Host $http_host;
        proxy_redirect off;

        # If you don't find the filename in the static files
        # Then request it from the unicorn server
        if (!-f $request_filename) {
            proxy_pass http://127.0.0.1:3000;
            break;
        }
    }

    error_page 500 502 503 504 /500.html;
    location = /500.html {
        root /var/www/apps/comiguide/current/public;
    }
}
```
