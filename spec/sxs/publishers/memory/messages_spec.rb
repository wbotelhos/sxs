# frozen_string_literal: true

RSpec.describe SXS::Publishers::Memory, '#messages' do
  let!(:body) { { key: 'value' }.to_json }
  let!(:queue_url) { 'queue_url' }
  let!(:publisher) { described_class.new queue_url }

  it 'returns the messages', :sxs do
    publisher.publish body

    expect(publisher.messages).to eq ['{"key":"value"}']
  end
end
