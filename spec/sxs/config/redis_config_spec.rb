# frozen_string_literal: true

RSpec.describe SXS::Config, 'redis_config' do
  it 'returns the default filters' do
    expect(described_class.new.redis_config).to eq({})
  end
end
