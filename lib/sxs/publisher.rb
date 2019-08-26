# frozen_string_literal: true

module SXS
  class Publisher
    def initialize(queue_url, provider:)
      @provider  = provider
      @queue_url = queue_url
    end

    def publish(body)
      publisher.publish(body)
    end

    private

    def environment
      ENV['RAILS_ENV']
    end

    def memory
      SXS::Publishers::Memory
    end

    def provider
      return provider_select(ENV['SXS_PROVIDER']) unless ENV['SXS_PROVIDER'].nil?

      return provider_select(@provider) if environment == 'production'

      { 'development' => redis, 'test' => memory }[environment]
    end

    def provider_select(name)
      value = { memory: memory, redis: redis, sqs: sqs }[name&.to_sym]

      if value.nil?
        raise ArgumentError, 'Missing provider! Availables: :memory, :redis, :sns or :sqs'
      end

      value
    end

    def publisher
      @publisher ||= provider.new(@queue_url)
    end

    def redis
      SXS::Publishers::Redis
    end

    def sqs
      SXS::Publishers::SQS
    end
  end
end
