# frozen_string_literal: true

RSpec.describe SXS::Publishers::Memory, '#include?' do
  let!(:publisher_1) { described_class.new 'queue_url_1' }
  let!(:publisher_2) { described_class.new 'queue_url_2' }

  before do
    publisher_1.publish({ key: 'value.1' }.to_json)
    publisher_1.publish({ key: 'value.2' }.to_json)
    publisher_2.publish({ key: 'value.3' }.to_json)
  end

  it 'checks if given message is included on queue', :sxs do
    expect(publisher_1.include?('{"key":"value.1"}')).to eq true
    expect(publisher_1.include?('{"key":"missing"}')).to eq false
    expect(publisher_2.include?('{"key":"value.3"}')).to eq true
  end
end
