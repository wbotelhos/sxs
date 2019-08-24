# frozen_string_literal: true

module SXS
  require 'sxs/config'
  require 'sxs/publisher'
  require 'sxs/publishers'

  class << self
    def config
      @config ||= ::SXS::Config.new
    end

    def configure
      yield config
    end
  end
end
