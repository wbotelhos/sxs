# frozen_string_literal: true

module SXS
  class Publisher
    def initialize(queue_url, provider: nil)
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

    def publisher
      @publisher ||= provider.new(@queue_url)
    end

    def provider
      return { memory: memory, redis: redis, sqs: sqs }[@provider.to_sym] if @provider

      if environment == 'production'
        raise ArgumentError, 'missing provider: redis, sqs, sns or memory'
      end

      { 'development' => redis, 'test' => memory }[environment]
    end

    def redis
      SXS::Publishers::Redis
    end

    def sqs
      SXS::Publishers::SQS
    end
  end
end
