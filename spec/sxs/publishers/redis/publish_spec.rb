# frozen_string_literal: true

RSpec.describe SXS::Publishers::Redis, '#publish' do
  let!(:body) { { key: 'value' }.to_json }
  let!(:queue_url) { 'queue_url' }
  let!(:publisher) { described_class.new queue_url }
  let!(:redis) { ::Redis.new }

  it 'publishes the message' do
    publisher.publish body

    expect(redis.rpop(queue_url)).to eq '{"key":"value"}'
  end
end
