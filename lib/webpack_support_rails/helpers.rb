require 'webpack_support_rails/webpack_support'

module WebpackSupportRails
  module Helpers
    def webpack_bundle_tag(bundle)
      filename = WebpackSupport.bundle_file(bundle)
      src = "#{compute_asset_host}/assets/javascripts/#{filename}"
      javascript_include_tag(src)
    end

    def webpack_bundle_inline(bundle)
      return webpack_bundle_tag(bundle) if WebpackSupportRails.bypass_inline_webpack
      filename = WebpackSupport.bundle_file(bundle)
      javascript_tag File.read(Rails.root.join('public', 'assets', 'javascripts', filename))
    end

    def webpack_manifest_script
      javascript_tag "window.webpackManifest = #{WebpackSupport.chunk_manifest_json}"
    end
  end
end