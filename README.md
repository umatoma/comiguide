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
    listen 80;
    server_name comiguide.net;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl spdy;
    server_name comiguide.net;

    keepalive_timeout 5;

    # Location of our static files
    root /var/www/apps/comiguide/current/public;

    ssl_certificate      /etc/nginx/certs/sslstore.comiguide.net.pem;
    ssl_certificate_key  /etc/nginx/certs/sslstore.comiguide.net.key;
    ssl_session_timeout  5m;
    ssl_protocols  TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
    ssl_prefer_server_ciphers   on;

    # Gzip compression
    gzip on;
    gzip_min_length 1100;
    gzip_buffers 4 32k;
    gzip_types text/plain text/xml text/css text/javascript application/x-javascript application/xhtml+xml application/xml;
    gzip_vary on;
    gzip_proxied any;

    # Proxy
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

    # Error pages
    error_page 500 502 503 504 /500.html;
    location = /500.html {
        root /var/www/apps/comiguide/current/public;
    }
}
```
