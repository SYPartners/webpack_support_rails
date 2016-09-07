require 'webpack_support_rails/helpers'

module WebpackSupportRails
  class Railtie < Rails::Railtie
    # Allows us to use [.] dot notation for config properties
    config.webpack_support = ActiveSupport::OrderedOptions.new

    # Default config properties
    config.webpack_support.update_webpack_manifest_every_request = true
    config.webpack_support.bypass_inline_webpack = false

    initializer "webpack_support_rails.helpers" do
      # Include WebpackSupportRails::Helpers with base ActionView
      ActionView::Base.send :include, Helpers
    end

    rake_tasks do
      load 'tasks/webpack.rake'
    end
  end
end