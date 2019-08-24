# frozen_string_literal: true

module SXS
  module Publishers
    require 'aws-sdk-sqs'

    class SQS
      def initialize(queue_url, resource: ::Aws::SQS::Resource)
        @queue_url = queue_url
        @resource  = resource
      end

      def publish(body)
        queue.send_message message_body: body
      end

      private

      def queue
        @queue ||= @resource.new.queue(@queue_url)
      end
    end
  end
end
