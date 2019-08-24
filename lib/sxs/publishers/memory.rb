# frozen_string_literal: true

module SXS
  module Publishers
    class Memory
      extend Forwardable

      attr_reader :queue_url

      def_delegators :messages, :include?, :size

      def initialize(queue_url)
        @queue_url = queue_url
      end

      def messages
        self.class.queues[@queue_url]
      end

      def publish(body)
        self.class.queues[@queue_url] ||= []
        self.class.queues[@queue_url] << body
      end

      def self.clear
        @queues = {}
      end

      def self.queues
        @queues ||= {}
      end
    end
  end
end
