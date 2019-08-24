# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'fakeredis/rspec'
require 'pry-byebug'
require 'rspec'
require 'sxs'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.after(:each, :sxs) do
    SXS::Publishers::Memory.clear
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order            = :random
  config.profile_examples = true
end
