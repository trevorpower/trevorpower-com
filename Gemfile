source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# To use debugger
# gem 'ruby-debug19', require => 'ruby-debug'

# Bundle the extra gems:
gem 'nokogiri'
gem 'aws-s3', :require => 'aws/s3'
gem 'mongo_mapper'
gem 'mm-multi-parameter-attributes'
gem 'sanitize'
gem 'html_truncator'
gem 'bson_ext'
gem 'jquery-rails'
gem 'bcrypt-ruby'

gem 'therubyracer'

gem 'haml-rails'
gem 'maruku'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'heroku_san'
  gem 'mongo_san', :git => 'git@github.com:trevorpower/Mongo-San.git'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'pickle'
  gem 'spork'
  gem 'turn', :require => false
  gem 'minitest'
end
