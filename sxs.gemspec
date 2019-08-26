# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sxs/version'

Gem::Specification.new do |spec|
  spec.author      = 'Washington Botelho'
  spec.description = 'SNS/SQS wrapper to make development (Redis) and test (Memory) environment transparent.'
  spec.email       = 'wbotelhos@gmail.com'
  spec.files       = Dir['lib/**/*'] + %w[CHANGELOG.md LICENSE README.md]
  spec.homepage    = 'https://github.com/wbotelhos/sxs'
  spec.license     = 'MIT'
  spec.name        = 'sxs'
  spec.platform    = Gem::Platform::RUBY
  spec.summary     = 'SNS and SQS Wrapper.'
  spec.test_files  = Dir['spec/**/*']
  spec.version     = SXS::VERSION

  spec.add_dependency 'aws-sdk-sns'
  spec.add_dependency 'aws-sdk-sqs'
  spec.add_dependency 'redis'

  spec.add_development_dependency 'fakeredis'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-rspec'
end
