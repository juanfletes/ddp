source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Flexible authentication solution for Rails with Warden
gem 'devise'
# Role management library with resource scoping
gem 'rolify'
# The authorization Gem for Ruby on Rails
gem 'cancancan', '~> 2.0'
# Client Side Validations made easy for Ruby on Rails
# gem 'client_side_validations'
# ActiveModel extension that automatically strips all attributes of leading and trailing whitespace before validation
gem 'strip_attributes'
# bootstrap-sass is a Sass-powered version of Bootstrap 3, ready to drop right into your Sass powered applications
gem 'bootstrap-sass', '~> 3.3.6'
# jQuery UI for the Rails asset pipeline
# gem 'jquery-ui-rails'
# Pines Notify for Rails 3.1 Asset Pipeline
gem 'pnotify-rails'
# Gema para auditoria
gem 'audited'
# provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.
gem 'font-awesome-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# A configurable and documented Rail view helper for adding gravatars into your Rails application
gem 'gravatar_image_tag'
# pg_search builds ActiveRecord named scopes that take advantage of PostgreSQL’s full text search
gem 'pg_search'
# The Moment.js JavaScript library ready to play with the Rails Asset Pipeline
gem 'momentjs-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # A Ruby static code analyzer, based on the community Ruby style guide
  gem 'rubocop', '~> 0.47.1', require: false
  # A rubocop formatter that outputs in checkstyle format
  gem 'rubocop-checkstyle_formatter'
  # Quick automated code review of your changes
  gem 'pronto', '0.8.2'
  # Pronto runner for Rubocop, ruby code analyzer
  gem 'pronto-rubocop', '0.8.0', require: false
  # An IRB alternative and runtime developer console
  gem 'pry'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
