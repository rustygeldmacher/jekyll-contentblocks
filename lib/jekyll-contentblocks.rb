require 'jekyll'

module Jekyll
  def self.version_less_than?(version)
    Gem::Version.new(VERSION) < Gem::Version.new(version)
  end

  def self.supports_collections?
    !version_less_than?('2.0.0')
  end
end

require 'jekyll/convertible'
require File.expand_path('../jekyll/convertible', __FILE__)

unless Jekyll.version_less_than?('2.0.0')
  require 'jekyll/renderer'
  require File.expand_path('../jekyll/renderer', __FILE__)
end

require 'jekyll/contentblocks/version'
require 'jekyll/content_block_tag'
require 'jekyll/tags/content_for'
require 'jekyll/tags/if_has_content'
require 'jekyll/tags/if_not_has_content'
require 'jekyll/tags/content_block'

Liquid::Template.register_tag('contentfor', Jekyll::Tags::ContentFor)
Liquid::Template.register_tag('ifhascontent', Jekyll::Tags::IfHasContent)
Liquid::Template.register_tag('ifnothascontent', Jekyll::Tags::IfNotHasContent)
Liquid::Template.register_tag('contentblock', Jekyll::Tags::ContentBlock)
