# frozen_string_literal: true

RSpec.describe SXS::Publishers::SQS, '#publish' do
  let!(:body) { { key: 'value' }.to_json }
  let!(:queue) { instance_spy 'Aws::SQS::Queue' }
  let!(:queue_url) { 'queue_url' }
  let!(:resource_client) { instance_double 'Aws::SQS::Resource' }

  context 'when resource is not injected' do
    let!(:publisher) { described_class.new queue_url }

    before do
      allow(::Aws::SQS::Resource).to receive(:new).and_return resource_client
      allow(resource_client).to receive(:queue).with(queue_url).and_return queue
    end

    it 'publishes the message' do
      publisher.publish body

      expect(queue).to have_received(:send_message).with(message_body: body)
    end
  end

  context 'when resource is injected' do
    let!(:resource) { class_double 'Aws::SQS::Resource', new: resource_client }
    let!(:publisher) { described_class.new queue_url, resource: resource }

    before do
      allow(resource_client).to receive(:queue).with(queue_url).and_return queue
    end

    it 'publishes the message' do
      publisher.publish body

      expect(queue).to have_received(:send_message).with(message_body: body)
    end
  end
end
