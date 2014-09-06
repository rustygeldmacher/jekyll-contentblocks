require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'

desc 'Run the test'
task :test do
  require 'jekyll'
  system 'rm -rf test/_site'
  version = `jekyll --version`.strip
  system 'jekyll build -s test/ -d test/_site &> /dev/null'
  unless system 'grep \'<h2 id=.sidebar.>SIDEBAR</h2>\' test/_site/index.html &> /dev/null'
    fail "#{version} failed!"
  end
  unless system 'grep "<p>3</p>" test/_site/index.html &> /dev/null'
    fail "#{version} failed!"
  end
  puts "#{version} pass!"
end

