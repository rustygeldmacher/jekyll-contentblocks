require 'nokogiri'
require 'jekyll-contentblocks'
require 'pry-byebug'
require 'open3'

module SpecHelpers
  def jekyll_version
    @jekyll_version ||= `jekyll --version`.strip.gsub('jekyll ', '')
  end

  def generate_test_site
    FileUtils.rm_rf('test/_site')
    exit_status = -1
    Open3.popen3('jekyll build -s test/ -d test/_site') do |i, o, e, t|
      o.read
      exit_status = t.value.exitstatus
    end
    exit_status == 0
  end

  def load_html(file)
    path = "test/_site/#{file}"
    if File.exists?(path)
      index_html = File.read(path)
      Nokogiri::Slop(index_html).html
    end
  end

  def load_item_html(item)
    if Jekyll.version_less_than?('2.1.0')
      load_html("items/#{item}.html")
    else
      load_html("items/#{item}/index.html")
    end
  end
end

RSpec.configure do |config|
  config.extend(SpecHelpers)
  config.include(SpecHelpers)
end
