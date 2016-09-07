namespace :webpack do
  desc "Copy's the config into config/webpack"
  task :init do
    puts "Let's do this!"
    Dir.mkdir "#{Rails.root}/config/webpack" unless File.exists? "#{Rails.root}/config/webpack"
    stub_files.each do |file_name|
      cp "#{File.dirname(__FILE__)}/../stubs/config/webpack/#{file_name}", "#{Rails.root}/config/webpack/#{file_name}" unless File.exists? "#{Rails.root}/config/webpack/#{file_name}"
    end
    puts "That's all folks!"
  end

  desc "Runs webpack in development mode with the --watch flag."
  task :watch do
    system "webpack --config=config/webpack/development.config.js --watch"
  end

  desc "Runs webpack in production mode/"
  task :prod do
    system "webpack --config=config/webpack/production.config.js"
  end
end

def stub_files
  %w(asset_map_writer.js cleaner.js common.config.js development.config.js production.config.js)
end