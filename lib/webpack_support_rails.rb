require "webpack_support_rails/version"
require 'webpack_support_rails/railtie' if defined?(Rails)

module WebpackSupportRails
  mattr_accessor :update_webpack_manifest_every_request, :bypass_inline_webpack
end
