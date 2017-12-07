source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
gem 'devise', '~> 4.3'
gem 'devise_token_auth', '~> 0.1.42'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'capybara', '~> 2.16', '>= 2.16.1'
  gem 'ffaker', '~> 2.7'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
end

group :development, :test do
  gem 'thin', '~> 1.7', '>= 1.7.2'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
