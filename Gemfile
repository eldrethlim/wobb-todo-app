source 'https://rubygems.org'

ruby "2.3.0"

gem 'rails', '4.2.5'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', github: 'rails/turbolinks', branch: 'master'
gem 'jbuilder', '~> 2.0'
gem 'bcrypt'
gem 'jwt'
gem 'active_model_serializers'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'slim-rails'
gem 'puma'
gem 'figaro'
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'faker'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.0.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

gem 'sdoc', '~> 0.4.0', group: :doc
