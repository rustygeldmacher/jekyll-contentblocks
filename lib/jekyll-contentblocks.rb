require "jekyll-contentblocks/version"
require "jekyll-contentblocks/convertible"
require "jekyll-contentblocks/common"
require "jekyll-contentblocks/content_for"
require "jekyll-contentblocks/content_block"

Liquid::Template.register_tag('contentfor', Jekyll::Tags::ContentFor)
Liquid::Template.register_tag('contentblock', Jekyll::Tags::ContentBlock)
