require 'jekyll'
require 'jekyll/convertible'
require File.expand_path('../jekyll/convertible', __FILE__)

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
