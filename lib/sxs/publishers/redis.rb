# frozen_string_literal: true

module SXS
  module Publishers
    class Redis
      require 'redis'

      def initialize(queue_url)
        @queue_url = queue_url
      end

      def publish(body)
        redis.rpush @queue_url, body
      end

      private

      def redis
        @redis ||= ::Redis.new(::SXS.config.redis_config)
      end
    end
  end
end
