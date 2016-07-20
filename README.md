[Oeco Architectes](http://www.oeco-architectes.com/)
----------------------------------------------------

[![Build Status](https://img.shields.io/travis/oeco-architectes/oeco/master.svg)](https://travis-ci.org/oeco-architectes/oeco)
[![Test Coverage](https://img.shields.io/codecov/c/github/oeco-architectes/oeco/master.svg)](https://codecov.io/github/oeco-architectes/oeco?branch=master)
[![Dependency Status](http://img.shields.io/gemnasium/oeco-architectes/oeco.svg)](https://gemnasium.com/oeco-architectes/oeco)

System dependencies
-------------------

* Rbenv
* Ruby 2.3.1
* Bundler
* PostgreSQL

```sh
brew install rbenv && rbenv init
rbenv install 2.3.1 && rbenv global 2.3.1 && rbenv rehash
gem install bundler
brew install postgresql
```

Installation
------------

```sh
bundle install
rails db:setup
rails db:fixtures:load
```

Local instance
--------------

```sh
rails s
```

Open http://localhost:3000/ in your browser.

Deployment
----------

See [Getting Started with Rails 5.x on Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails5)
for detailed instructions.

```sh
which heroku >/dev/null || brew install heroku
heroku login
heroku git:remote -a APP_NAME
heroku run rake db:migrate
heroku ps:scale web=1
heroku ps
heroku open
```
