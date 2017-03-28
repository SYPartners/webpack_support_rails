namespace :webpack do
  desc "Runs the initialization generator"
  task :init do
    fail 'npm cannot be found' unless system 'which npm'
    system 'npm init --force' unless File.exists? "#{Rails.root}/package.json"
    system 'npm i webpack glob chunk-manifest-webpack-plugin lodash babel-loader babel-core babel-preset-es2015 https://github.com/sypartners/webpack-support-rails.git#v0.1.1 --save-dev'
    system "rails g webpack_support_rails:initializer"
    Dir.mkdir_p "#{Rails.root}/app/assets/javascripts/entry" unless File.exists? "#{Rails.root}/app/assets/javascripts/entry"
  end

  desc "Copy's the common config into config/webpack"
  task :customize do
    puts "Let's do this!"
    Dir.mkdir "#{Rails.root}/config/webpack" unless File.exists? "#{Rails.root}/config/webpack"
    stub_files.each do |file_name|
      cp "#{File.dirname(__FILE__)}/../stubs/config/webpack/#{file_name}", "#{Rails.root}/config/webpack/#{file_name}" unless File.exists? "#{Rails.root}/config/webpack/#{file_name}"
    end
    puts "That's all folks!"
  end

  desc "Runs webpack in development mode with the --watch flag."
  task :watch do
    system "env CURRENT_RAILS_ROOT=#{Rails.root} node_modules/.bin/webpack --config=node_modules/webpack-support-rails/config/development.config.js --watch"
  end

  desc "Runs webpack in production mode/"
  task :prod do
    system "env CURRENT_RAILS_ROOT=#{Rails.root} node_modules/.bin/webpack --config=node_modules/webpack-support-rails/config/production.config.js"
  end
end

def stub_files
  %w(common.config.js)
end

def gem_lib_js_path
  "#{File.dirname(__FILE__)}/../js"
end