# frozen_string_literal: true

RSpec.describe SXS::Publisher, '#publish' do
  subject(:publisher) { described_class.new queue_url, provider: provider }

  let!(:body) { { key: 'value' }.to_json }
  let!(:queue_url) { 'queue_url' }

  context 'when provider is given' do
    context 'when provider is sqs' do
      let(:provider) { :sqs }

      let!(:sqs) { instance_spy 'SXS::Publishers::SQS' }

      before do
        allow(SXS::Publishers::SQS).to receive(:new).with(queue_url).and_return sqs
      end

      it 'publishes the message' do
        publisher.publish body

        expect(sqs).to have_received(:publish).with(body)
      end
    end

    context 'when provider is redis' do
      let(:provider) { :redis }

      let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

      before do
        allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis
      end

      it 'publishes the message' do
        publisher.publish body

        expect(redis).to have_received(:publish).with(body)
      end
    end

    context 'when provider is memory' do
      let(:provider) { :memory }

      let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

      before do
        allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory
      end

      it 'publishes the message' do
        publisher.publish body

        expect(memory).to have_received(:publish).with(body)
      end
    end
  end

  context 'when provider is not given' do
    let(:provider) { nil }

    context 'when rails env is development' do
      let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

      before do
        allow(ENV).to receive(:[]).with('RAILS_ENV').and_return 'development'
        allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis
      end

      it 'publishes the message on redis' do
        publisher.publish body

        expect(redis).to have_received(:publish).with(body)
      end
    end

    context 'when rails env is production' do
      let!(:error) { 'missing provider: redis, sqs, sns or memory' }

      before { allow(ENV).to receive(:[]).with('RAILS_ENV').and_return 'production' }

      it 'raises' do
        expect { publisher.publish body }.to raise_error ArgumentError, error
      end
    end

    context 'when rails env is test' do
      let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

      before do
        allow(ENV).to receive(:[]).with('RAILS_ENV').and_return 'test'
        allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory
      end

      it 'publishes the message on memory' do
        publisher.publish body

        expect(memory).to have_received(:publish).with(body)
      end
    end
  end
end
