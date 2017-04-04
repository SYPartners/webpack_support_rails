# WebpackSupportRails

This is a rather opinionated way to use [webpack](https://webpack.github.io/) with [Rails](http://rubyonrails.org/). We prevent the [Rails asset pipeline](http://guides.rubyonrails.org/asset_pipeline.html) from doing anything with Javascript and run webpack alongside the rails server. Per the default configuration, webpack transpiles out of the 'app/assets/javascripts' directory and into 'public/assets/javascripts'. It's pretty nice.

At this time, because this technique doesn't use the asset pipeline, it basically precludes you from running on Heroku unless you wanna check your production assets into git, which you almost certainly don't want to do.


## Opinions

 - AMD is life.
 - Common bundle without thinking.
 - Page bundles linked to src with src maps in development.
 - Page bundles inline in production.


## Installation

### Prereq

You'll need [node](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed. We don't cover that here. We recommend [nvm](https://github.com/creationix/nvm).

### Prep

This gem probably only works when rails isn't doing anything with Javascript. We start our projects like this:

    $ rails new --skip-javascript --skip-turbolinks app_name

If you have an existing project, perhaps you'll need to remove some gems or something. I tried to find a nice concise description on how to do so, but couldn't find one. If you end up doing this, perhaps you'd like to submit a pull request to update this readme.

### Install

Add this line to your application's Gemfile then `$ bundle`

```ruby
gem 'webpack_support_rails', :git => 'https://github.com/sypartners/webpack_support_rails.git'
```

##### NVM

If you're using nvm (or can run npm with sudo), this init task will install the necessary node packages:

    $ rake webpack:init

##### Not NVM

If you're not using nvm (or you need to run npm with `sudo`) the init task will fail. You can run the following manually:

    $ sudo npm init
    $ sudo npm i webpack glob chunk-manifest-webpack-plugin lodash babel-loader babel-core babel-preset-es2015 https://github.com/sypartners/webpack-support-rails.git#v0.1.1 --save-dev

### Add the common bundle to the application layout.

Add the following to applications In your `layouts/application.html.erb` to get the common bundle.

```erb
<%= webpack_bundle_tag 'common' %>
```


## Usage

### Developing

Start webpack in development mode and watch for changes with:

    $ rake webpack:watch

Entry points (e.g. a page's javascript) live in `app/assets/javascripts/entry` and can have one of the following extensions: `.js`, `.js6`, `.jsx`. The bundle will be named after the file without the extension eg: `some_file.js` will be bundled as `some_file`.

There are two ways to reference an entry point:

```erb
<%= webpack_bundle_tag 'some_file' %>
```

This will generate a script tag with a src that points to the transpiled file (and respects Rails' asset host).

```erb
<%= webpack_bundle_inline 'some_file' %>
```

In development mode, `webpack_bundle_inline` will also generate a script tag that links to the bundle. However, in production the bundle will be inlined in the src tag.

### Production

To run webpack to compile for production run:

    $ rake webpack:prod

This will transpile and compress and tag and all that for production.

### Common pattern

The general use case goes something like:
 - Create a controller action, e.g. `session#login`
 - Create an entry point javascript file, e.g. `login.js6`
 - Add the tag to the action's template, e.g. `<%= webpack_bundle_inline 'login' %>`
 - Restart the webpack:watch task to catch the new file.
 - Edit file, refresh page.
 - Lather, rinse, repeat.
 - Before packaging your app up for production run the webpack:prod task.
 - Deploy.
 - Profit.


## Extra config

The default configuration should be sufficient. If, for some reason, you don't find them to your liking, there are a couple things you can do.

If you want to fiddle with the webpack config, the following command will give you an entry point to do so:

    $ rake webpack:customize

This will generate `config/webpack/common.config.js` which will let you add entry points, webpack plugins, and additional loaders. This config object is merged into the defaults and we don't use it much, so there may be unexpected behavior. Let us know how it goes.

There are a couple behaviors that can be changed regardling the packaging and linking to the bundles. If you wanna fiddle with them, run

    $ rails g webpack_support_rails:initializer

and then read `config/initializers/webpack_support_rails.rb`.


