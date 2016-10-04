var path = require('path');
var _ = require('lodash');

var webpack = require('webpack');
var chunk_manifest = require('chunk-manifest-webpack-plugin');

var cleaner = require('./cleaner');
var asset_map_writer = require('./asset_map_writer');

var rails_path = process.env.CURRENT_RAILS_ROOT;


var src_path = path.join(rails_path, 'app', 'assets', 'javascripts');
var build_path = path.join(rails_path, 'public', 'assets', 'javascripts');
var asset_map_path = path.join(rails_path, 'public', 'assets', 'asset_map.json');


var config = {
    context: src_path,
    entry: {
        app: './app.js'
    }
};

config = _.merge(config, {
    debug: true,
    displayErrorDetails: true,
    outputPathinfo: true
});

config.output = {
    path: build_path,
    filename: '[name]-[chunkhash].js',
    chunkFilename: '[id]-[chunkhash].js',
};

config.resolve = {
    root: src_path,
    extensions: ['', '.js', '.js6', '.jsx', '.json'],
    alias: {
        underscore: 'lodash',
    }
};

config.plugins = [
    cleaner,
    new asset_map_writer(asset_map_path),
    new webpack.optimize.CommonsChunkPlugin('common', 'common-[chunkhash].js'),
    new chunk_manifest({ filename: '../webpack-chunk-manifest.json', manfiestVariable: 'webpackBundleManifest' }),
    // new webpack.ProvidePlugin({
    //     $: "jquery",
    //     jQuery: "jquery",
    // })
];

config.module = {
    loaders: [
        // { test: /\.vue$/, loader: 'vue' },
        { test: /\.js([6x])?$/, exclude: /node_modules/, loader: "babel", query: {presets: ['es2015'] } },
        { include: /\.json$/, loaders: ["json-loader"] }
    ]
};

module.exports = config;