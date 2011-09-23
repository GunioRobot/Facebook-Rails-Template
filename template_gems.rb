run 'rm Gemfile'
file 'Gemfile', <<-CODE
source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'haml', '3.1.3'
gem 'settingslogic',  '2.0.6'
gem 'aws-s3',         '0.6.2'
gem 'facebooker2',    '0.0.11'
gem 'mogli', '0.0.26'

group :development do
  gem 'sqlite3'
  gem 'rails3-generators'
  gem 'awesome_print', :require => 'ap'
end

group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
  gem 'pg', :require => 'pg'
end

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'compass', :git => 'git://github.com/chriseppstein/compass.git', :branch => 'rails31'
  gem 'uglifier'
end
CODE

run 'bundle'