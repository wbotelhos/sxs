# frozen_string_literal: true

RSpec.describe SXS, '#configure' do
  it 'yields the default config' do
    described_class.configure do |conf|
      expect(conf).to be_a_instance_of SXS::Config
    end
  end
end
