
source 'http://rubygems.org'

gem 'gibberish'
gem 'rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'mongoid'
gem 'bson_ext'
gem 'rails3-generators'
gem 'simple_form'
gem 'haml'
gem 'haml-rails'
gem 'aws-s3'
gem 'mongoid-paperclip', require: 'mongoid_paperclip'
gem 'devise'
gem 'bcrypt-ruby'
gem 'airbrake'
gem 'stripe'

group :production do
  gem 'thin'
 # ruby '1.9.3'
  gem 'pg'
end

group :development do
  gem 'heroku'
  gem 'taps'
  gem 'unicorn'
  gem 'hpricot'
  gem 'pry-rails'
end

group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'timecop'
  gem 'vcr'
  gem 'fakeweb'
  gem 'email_spec' 
  gem 'pry'
  gem 'pry-nav'
  gem 'puma'

  # Pretty printed test output
  gem 'turn', require: false

  gem 'simplecov',      require: false
  gem 'simplecov-rcov', require: false
end

