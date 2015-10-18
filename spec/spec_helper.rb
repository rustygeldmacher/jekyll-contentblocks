require 'nokogiri'
require 'jekyll-contentblocks'
require 'pry-byebug'

module SpecHelpers
  def jekyll_version
    @jekyll_version ||= `jekyll --version`.strip.gsub('jekyll ', '')
  end

  def generate_test_site
    system 'rm -rf test/_site'
    system 'jekyll build -s test/ -d test/_site &> /dev/null'
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
