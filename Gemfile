source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'graphql', '~> 1.12', '>= 1.12.3'
gem 'giphy', '~> 3.0'
gem 'sidekiq', '~> 6.2', '>= 6.2.1'
gem 'back_ops', '~> 0.2.0'

# Assets
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'factory_bot_rails', '~> 6.1'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'graphiql-rails', group: :development
