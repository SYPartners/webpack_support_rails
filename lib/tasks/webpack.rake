namespace :webpack do
  desc "Runs the initialization generator"
  task :init do
    fail 'npm cannot be found' unless system 'which npm'
    system 'npm init --force' unless File.exists? "#{Rails.root}/package.json"
    system 'npm i webpack@^2.3 glob@^7.1 chunk-manifest-webpack-plugin@^1.0 lodash@^4.16 babel-loader@^6.2 babel-core@^6.18 babel-preset-es2015@^6.18 https://github.com/sypartners/webpack-support-rails.git --save-dev'
    system "rails g webpack_support_rails:initializer"
    FileUtils.mkdir_p "#{Rails.root}/app/assets/javascripts/entry" unless File.exists? "#{Rails.root}/app/assets/javascripts/entry"
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