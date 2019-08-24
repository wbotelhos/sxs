# frozen_string_literal: true

module SXS
  class Config
    attr_reader :redis_config

    def initialize
      @redis_config = {}
    end

    def redis(options = {})
      @redis_config.merge!(options) unless options.empty?
    end
  end
end
