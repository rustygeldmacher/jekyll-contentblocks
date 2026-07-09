require 'nokogiri'
require 'jekyll-contentblocks'
require 'open3'

module SpecHelpers
  def jekyll_version
    @jekyll_version ||= `jekyll --version`.strip.gsub('jekyll ', '')
  end

  def generate_test_site
    FileUtils.rm_rf('test/_site')
    output, status = Open3.capture2e('jekyll build -s test/ -d test/_site')
    # Keep passing runs quiet; only surface the build log when it actually fails.
    warn output unless status.success?
    status.success?
  end

  def load_html(file)
    path = "test/_site/#{file}"
    if File.exist?(path)
      index_html = File.read(path)
      Nokogiri::Slop(index_html).html
    end
  end

  def load_item_html(item)
    load_html("items/#{item}/index.html")
  end
end

RSpec.configure do |config|
  config.extend(SpecHelpers)
  config.include(SpecHelpers)
end
