source 'https://rubygems.org'
ruby '2.1.0'

gem 'rails', '4.0.3'
gem 'pg'
gem 'dotenv-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 1.2'
gem 'devise'
gem 'chronic'
gem 'time_difference' # Get time difference between two dates
gem 'jquery-rails'
gem 'coffee-rails'
gem 'bootstrap-sass', '~> 3.1.1'


group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'  # Simulates a user clicking things in your app (testing)
  gem 'launchy'   # Opens app in a broswer
  gem 'faker'     # Populates fake data
  gem 'simplecov', '~> 0.7.1', require: false
  gem 'poltergeist'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'guard-rspec', require: false
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  gem 'factory_girl_rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'bullet'
  gem 'debugger'
  gem 'quiet_assets'
  # gem 'rack-mini-profiler'  # for load times
  gem 'rails-erd', require: false   # makes model diagrams
  gem 'rails_best_practices', require: false
  gem 'coffee-rails-source-maps'
end
