# frozen_string_literal: true

RSpec.describe SXS::Publishers::Memory, '.clear' do
  let!(:publisher_1) { described_class.new 'queue_url_1' }
  let!(:publisher_2) { described_class.new 'queue_url_2' }

  before do
    publisher_1.publish({ key: 'value.1' }.to_json)
    publisher_2.publish({ key: 'value.2' }.to_json)
  end

  it 'clears the queues', :sxs do
    described_class.clear

    expect(described_class.queues).to eq({})
  end
end
