source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.7'
# Use mysql as the database for Active Record
gem 'mysql2', '0.4.5'
# Use Puma as the app server
gem 'puma', '3.10.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '1.0.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '3.6.0'
end

group :test do
  gem 'database_cleaner', '1.5.3'
  gem 'shoulda-matchers', '3.1.1'
  gem 'factory_girl_rails', '4.8.0'
  gem 'faker', '1.7.3'
end

group :development do
  gem 'listen', '3.0.8'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.0.1'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec', '1.0.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise', '4.3.0'

gem 'active_model_serializers', '0.10.6'

gem 'ransack', '1.8.2'

gem 'omniauth', '1.6.1'

gem 'devise_token_auth', '0.1.42'

gem 'rails-i18n', '5.0.4'