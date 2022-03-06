source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.2", ">= 7.0.2.2"
gem "sqlite3", "~> 1.4"

gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "bcrypt", "~> 3.1.7"
gem 'doorkeeper'
gem 'active_model_serializers', '~> 0.10.2'

group :development, :test do
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'factory_bot_rails', '~> 6.1'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker'
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
end

group :development do
  
end

