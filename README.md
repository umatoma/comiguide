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
