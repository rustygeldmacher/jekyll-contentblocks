require 'jekyll'

module Jekyll
  def self.version_less_than?(version)
    Gem::Version.new(VERSION) < Gem::Version.new(version)
  end

  def self.supports_collections?
    !version_less_than?('2.0.0')
  end
end

if Jekyll.version_less_than?('3.0.0')
  require 'jekyll/content_blocks/convertible'
  unless Jekyll.version_less_than?('2.0.0')
    require 'jekyll/content_blocks/renderer'
  end
else
  require 'jekyll/content_blocks/pre_render_hook'
  [:documents, :pages, :posts].each do |content_type|
    Jekyll::Hooks.register content_type, :pre_render do |doc, payload|
      Jekyll::ContentBlocks::PreRenderHook.call(doc, payload)
    end
  end
end

require 'jekyll/content_blocks/version'
require 'jekyll/content_blocks/content_block_tag'
require 'jekyll/tags/content_for'
require 'jekyll/tags/if_has_content'
require 'jekyll/tags/if_not_has_content'
require 'jekyll/tags/content_block'

Liquid::Template.register_tag('contentfor', Jekyll::Tags::ContentFor)
Liquid::Template.register_tag('ifhascontent', Jekyll::Tags::IfHasContent)
Liquid::Template.register_tag('ifnothascontent', Jekyll::Tags::IfNotHasContent)
Liquid::Template.register_tag('contentblock', Jekyll::Tags::ContentBlock)
