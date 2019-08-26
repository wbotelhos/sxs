# frozen_string_literal: true

RSpec.describe SXS::Publisher, '#publish' do
  subject(:publisher) { described_class.new queue_url, provider: provider }

  let!(:body) { { key: 'value' }.to_json }
  let!(:queue_url) { 'queue_url' }

  after do
    ENV['RAILS_ENV'] = 'test'

    ENV.delete 'SXS_PROVIDER'
  end

  context 'when provider is sqs' do
    let(:provider) { :sqs }

    context 'when rails env is development' do
      before { ENV['RAILS_ENV'] = 'development' }

      context 'when sxs provider is not setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis
        end

        it 'overwrites with redis' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory

          ENV['SXS_PROVIDER'] = 'memory'
        end

        it 'is used' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end
    end

    context 'when rails env is production' do
      before { ENV['RAILS_ENV'] = 'production' }

      context 'when sxs provider is not setted' do
        let!(:sqs) { instance_spy 'SXS::Publishers::SQS' }

        before do
          allow(SXS::Publishers::SQS).to receive(:new).with(queue_url).and_return sqs
        end

        it 'uses the given provider' do
          publisher.publish body

          expect(sqs).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis

          ENV['SXS_PROVIDER'] = 'redis'
        end

        it 'is used' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end
    end

    context 'when rails env is test' do
      before { ENV['RAILS_ENV'] = 'test' }

      context 'when sxs provider is not setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory
        end

        it 'overwrites with memory' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis

          ENV['SXS_PROVIDER'] = 'redis'
        end

        it 'is used' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end
    end
  end

  context 'when provider is redis' do
    let(:provider) { :redis }

    context 'when rails env is development' do
      before { ENV['RAILS_ENV'] = 'development' }

      context 'when sxs provider is not setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis
        end

        it 'overwrites with redis' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory

          ENV['SXS_PROVIDER'] = 'memory'
        end

        it 'is used' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end
    end

    context 'when rails env is production' do
      before { ENV['RAILS_ENV'] = 'production' }

      context 'when sxs provider is not setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis
        end

        it 'uses the given provider' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory

          ENV['SXS_PROVIDER'] = 'memory'
        end

        it 'is used' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end
    end

    context 'when rails env is test' do
      before do
        ENV['RAILS_ENV'] = 'test'
      end

      after do
        ENV['RAILS_ENV'] = 'test'
      end

      context 'when sxs provider is not setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory
        end

        it 'overwrites with memory' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory
        end

        before do
          ENV['SXS_PROVIDER'] = 'memory'
        end

        after do
          ENV.delete 'SXS_PROVIDER'
        end

        it 'is used' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end
    end
  end

  context 'when provider is memory' do
    let(:provider) { :memory }

    context 'when rails env is development' do
      before do
        ENV['RAILS_ENV'] = 'development'
      end

      after do
        ENV['RAILS_ENV'] = 'test'
      end

      context 'when sxs provider is not setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis
        end

        it 'overwrites with redis' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis

          ENV['SXS_PROVIDER'] = 'redis'
        end

        it 'is used' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end
    end

    context 'when rails env is production' do
      before { ENV['RAILS_ENV'] = 'production' }

      context 'when sxs provider is not setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory
        end

        it 'uses the given provider' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis

          ENV['SXS_PROVIDER'] = 'redis'
        end

        it 'is used' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end
    end

    context 'when rails env is test' do
      before { ENV['RAILS_ENV'] = 'test' }

      context 'when sxs provider is not setted' do
        let!(:memory) { instance_spy 'SXS::Publishers::Memory' }

        before do
          allow(SXS::Publishers::Memory).to receive(:new).with(queue_url).and_return memory
        end

        it 'overwrites with memory' do
          publisher.publish body

          expect(memory).to have_received(:publish).with(body)
        end
      end

      context 'when sxs provider is setted' do
        let!(:redis) { instance_spy 'SXS::Publishers::Redis' }

        before do
          allow(SXS::Publishers::Redis).to receive(:new).with(queue_url).and_return redis

          ENV['SXS_PROVIDER'] = 'redis'
        end

        it 'is used' do
          publisher.publish body

          expect(redis).to have_received(:publish).with(body)
        end
      end
    end
  end
end
