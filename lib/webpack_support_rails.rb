require "webpack_support_rails/version"
require 'webpack_support_rails/railtie' if defined?(Rails)

module WebpackSupportRails
  # Forces the webpack manifest to be updated on every page request.
  # Set to true for development
  # Set to false in production to increase response speed
  # Default: !Rails.env.production?
  mattr_accessor :update_webpack_manifest_every_request
  @@update_webpack_manifest_every_request = !Rails.env.production?

  # When set to true, all js bundles will be loaded externally instead of inlined.
  # Set to true for development
  # Set to false in production to inline javascript
  # Default: !Rails.env.production?
  mattr_accessor :bypass_inline_webpack
  @@bypass_inline_webpack = !Rails.env.production?
end
