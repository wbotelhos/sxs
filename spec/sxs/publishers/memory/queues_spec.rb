# frozen_string_literal: true

RSpec.describe SXS::Publishers::Memory, '.queues' do
  let!(:publisher_1) { described_class.new 'queue_url_1' }
  let!(:publisher_2) { described_class.new 'queue_url_2' }

  before do
    publisher_1.publish({ key: 'value.1' }.to_json)
    publisher_1.publish({ key: 'value.2' }.to_json)
    publisher_2.publish({ key: 'value.3' }.to_json)
  end

  it 'returns the queues with its messages', :sxs do
    expect(described_class.queues).to eq(
      'queue_url_1' => ['{"key":"value.1"}', '{"key":"value.2"}'],
      'queue_url_2' => ['{"key":"value.3"}']
    )
  end
end
