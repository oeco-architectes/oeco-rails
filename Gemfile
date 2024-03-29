# frozen_string_literal: true
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use config for custom application settings
gem 'config'
# User Heroku for deployment
gem 'platform-api'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Redcarpet for Mardown parsing
gem 'redcarpet'

# Use Foundation for Rails for styling
gem 'foundation-rails'

# Use browserify-rails for NPM support
gem 'browserify-rails'

# Use PostCSS/Autoprefixer for CSS
gem 'autoprefixer-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platform: :mri

  gem 'rubocop', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere
  # in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'codecov', require: false
  gem 'simplecov', require: false
end

group :production, :staging do
  # To run on Heroku, your app must have the rails_12factor gem
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '2.3.1'
