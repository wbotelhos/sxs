# frozen_string_literal: true

module SXS
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    desc 'creates an initializer'

    def copy_initializer
      copy_file 'config/initializers/sxs.rb', 'config/initializers/sxs.rb'
    end
  end
end
