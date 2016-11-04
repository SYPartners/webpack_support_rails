require 'webpack_support_rails/helpers'

module WebpackSupportRails
  class Railtie < Rails::Railtie

    initializer "webpack_support_rails.helpers" do
      # Include WebpackSupportRails::Helpers with base ActionView
      ActionView::Base.send :include, Helpers
    end

    rake_tasks do
      load 'tasks/webpack.rake'
    end
  end
end