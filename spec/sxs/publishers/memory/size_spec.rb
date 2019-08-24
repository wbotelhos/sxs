# frozen_string_literal: true

RSpec.describe SXS::Publishers::Memory, '#size' do
  let!(:publisher) { described_class.new 'queue_url' }

  before do
    publisher.publish({ key: 'value.1' }.to_json)
    publisher.publish({ key: 'value.2' }.to_json)
  end

  it 'returns the size of items on queues', :sxs do
    expect(publisher.size).to eq 2
  end
end
