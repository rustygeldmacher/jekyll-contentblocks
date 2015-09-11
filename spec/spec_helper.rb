require 'nokogiri'

module SpecHelpers
  def generate_test_site
    system 'rm -rf test/_site'
    system 'jekyll build -s test/ -d test/_site &> /dev/null'
  end

  def load_index_html
    index_html = File.read('test/_site/index.html')
    Nokogiri::Slop(index_html)
  end
end

RSpec.configure do |config|
  config.include(SpecHelpers)
end
