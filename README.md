# WebpackSupportRails

This is a **HIGHLY OPINIONATED** way to use webpack with Rails

## TODOs

- [x] generate an initializer and set config values there
- [x] have all source maps removed with their main js bundle file
- [x] move all default config into gem (maybe - not sure how i feel about this)
- [x] have config be extendable through js config objects and leave our boilerplate untouched

## Installation (for realz)

    $ rails new --skip-javascript --skip-turbolinks app

Add this line to your application's Gemfile:

```ruby
gem 'webpack_support_rails', :git => 'https://github.com/sypartners/webpack_support_rails.git', :tag => 'v0.1.5'
```

And then execute:

    $ bundle install

## Configuration

This assumes you already have node and npm installed. Run the following:
                                                                                                                                                                                                                                                       
    $ rake webpack:init

This creates the following file where config can be set: `config/initializers/webpack_support_rails.rb`

The default values are dependant on the Rails environment and will be sensible for both prod and development. 

This also creates a package.json if it doesn't exist, and installs all the needed dependencies.

If for some reason, you need to run npm with `sudo` the above command will fail and you can run the following manually:

    $ sudo npm init
    
    $ sudo npm i webpack glob chunk-manifest-webpack-plugin lodash babel-loader babel-core babel-preset-es2015 https://github.com/sypartners/webpack-support-rails.git#v0.1.1 --save-dev

    $ rails g webpack_support_rails:initializer

## Usage

App entry points are autoMAGICALLY generated from `.js`, `.js6`, and `.jsx` files located in `app/assets/javascripts/entry`. The bundle name will be the file name without the extension eg: `some_file.js` will be bundled as `some_file`.

App entry points, webpack plugins, and additional loaders can be added in `config/webpack/common.config.js`. You will need to create this and it must be a webpack config object. It is merged into the defaults, so there may be unexpected behavior. To scaffold the webpack config:
                                                                                                                                                                                                                                                       
    $ rake webpack:customize

To run webpack in development mode and watch for changes use:

    $ rake webpack:watch

To run webpack in production mode ONCE use:

    $ rake webpack:prod

In your `layouts/application.html.erb` you will need to add

```erb
<%= webpack_bundle_tag 'common' %>
```

For the entry point `my-entry-point` you can either reference the webpack entry point file:

```erb
<%= webpack_bundle_tag 'my-entry-point' %>
```

**OR** you can have the contents of the bundle loaded inline

```erb
<%= webpack_bundle_inline 'my-entry-point' %>
```


## Development (boilerplate)

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing (boilerplate)

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/webpack_support_rails.

