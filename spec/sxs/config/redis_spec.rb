# frozen_string_literal: true

RSpec.describe SXS::Config, 'redis' do
  subject(:config) { described_class.new }

  before { config.redis db: 0, host: :localhost, port: 6379 }

  it 'overwrite the config' do
    expect(config.redis_config).to eq(db: 0, host: :localhost, port: 6379)
  end
end
