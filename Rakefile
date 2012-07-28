# -*- ruby -*-

require 'rake/sprocketstask'
Rake::SprocketsTask.new do |t|
  env = Sprockets::Environment.new
  env.append_path 'js'
  env.append_path 'css'

  t.environment = env
  t.output = "./public/assets"
  t.assets = %w(styles.css main.js)
end

namespace :assets do
  desc "Renames assets"
  task :rename do
    `mv public/assets/main{-*,}.js`
    `mv public/assets/styles{-*,}.css`
  end

  desc "Build assets" 
  task :build do
    Rake::Task['assets'].invoke
    Rake::Task['assets:rename'].invoke
  end
end
