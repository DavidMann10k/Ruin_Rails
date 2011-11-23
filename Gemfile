source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'gravatar_image_tag', '1.0.0.pre2'
gem 'jquery-rails'
gem "heroku"
gem "rack", '1.3.5'
gem "omniauth", '~> 0.3.2'
gem 'faker', '0.3.1'
gem 'kaminari'

group :production do
  gem 'pg'
  gem 'therubyracer-heroku'
  gem 'thin'
end

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end


group :development do
  gem 'rspec-rails'
  gem 'sqlite3'
  gem "factory_girl_rails", "~> 1.2"
end

group :test do
  gem 'rspec-rails'
  gem 'webrat'
  gem 'spork', '0.9.0.rc5'
  gem "factory_girl_rails", "~> 1.2"
  gem 'sqlite3'
end