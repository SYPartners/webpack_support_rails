module WebpackSupportRails
  class WebpackSupport
    def self.asset_map_path
      Rails.root.join('public', 'assets', 'asset_map.json')
    end

    def self.chunk_manifest_path
      Rails.root.join('public', 'assets', 'webpack-chunk-manifest.json')
    end

    def self.update_manifests
      return if !(Rails.configuration.webpack_support.update_webpack_manifest_every_request || @asset_manifest.nil? || @chunk_manifest_json.nil?)

      raise "Can't find asset map at #{asset_map_path}!" unless File.exist?(asset_map_path)
      raise "Can't find chunk manifest at #{chunk_manifest_path}!" unless File.exist?(chunk_manifest_path)

      update_asset_manifest if asset_manifest_out_of_date
      update_chunk_manifest if chunk_manifest_out_of_date
    end

    def self.asset_manifest_out_of_date
      @asset_manifest_updated_at.nil? || @asset_manifest_updated_at < File.mtime(asset_map_path)
    end

    def self.update_asset_manifest
      @asset_manifest = JSON.parse(File.read(asset_map_path))
      @asset_manifest_updated_at = Time.zone.now
    end

    def self.chunk_manifest_out_of_date
      @chunk_manifest_updated_at.nil? || @chunk_manifest_updated_at < File.mtime(chunk_manifest_path)
    end

    def self.update_chunk_manifest
      @chunk_manifest_json = File.read(chunk_manifest_path).to_json
      @chunk_manifest_updated_at = Time.zone.now
    end

    def self.bundle_file bundle
      update_manifests

      @asset_manifest[bundle]
    end

    def self.chunk_manifest_json
      update_manifests

      @chunk_manifest_json
    end
  end
end