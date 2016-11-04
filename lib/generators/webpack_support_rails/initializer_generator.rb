require 'rails/generators'

module WebpackSupportRails
  class InitializerGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Webpack Support Rails installation generator'
    def initialize
      template 'initializer.erb', 'config/initializers/webpack_support_rails.rb'
    end
  end
end