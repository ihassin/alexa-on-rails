source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'alexa_generator'
gem 'alexa_rubykit'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
# gem 'mysql2'
gem 'sqlite3'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.1'
gem 'rake'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
