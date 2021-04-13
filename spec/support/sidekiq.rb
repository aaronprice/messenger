require 'sidekiq/testing'

RSpec.configure do |config|
  Sidekiq::Testing.inline!
end