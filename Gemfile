source "https://rubygems.org"

ruby "3.4.1"

# Rails framework
gem "rails", "~> 7.2.2", ">= 7.2.2.1"

# Asset pipeline
gem "sprockets-rails"

# Database
gem "sqlite3", ">= 1.4"
gem "pg"

# Web server
gem "puma", ">= 5.0"

# JavaScript
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# JSON APIs
gem "jbuilder"

# Time zone data for Windows
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Performance
gem "bootsnap", require: false

# Templating
gem "slim"

# Form handling
gem "simple_form"
gem "cocoon"

# File uploads
gem "carrierwave"
gem "rmagick"

# Frontend
gem "jquery-rails"
gem "select2-rails"
gem "bootstrap", "~> 5.3"
gem "sass-rails"
gem "view_component", "~> 3.21"

# HTTP client
gem "http"

# Authentication and authorization
gem "devise"
gem "cancancan"
gem "role_model"

# Background job processing
gem "sidekiq"

# Miscellaneous
gem "active_flag"
gem "ajax-datatables-rails"
gem "responders"
gem "globalid"

# Development and test
group :development, :test do
  gem "byebug", platforms: [ :mri, :mingw, :x64_mingw ]
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "rails-controller-testing"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
