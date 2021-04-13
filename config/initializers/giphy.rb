Giphy::Configuration.configure do |config|
  config.api_key = Rails.application.credentials[Rails.env.to_sym][:giphy][:key]
end