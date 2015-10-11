# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/content_blocks/version'

Gem::Specification.new do |gem|
  gem.name          = "jekyll-contentblocks"
  gem.version       = Jekyll::ContentBlocks::VERSION
  gem.authors       = ["Rusty Geldmacher"]
  gem.email         = ["russell.geldmacher@gmail.com"]
  gem.description   = %q{Provides a mechanism for passing content up to the layout, like Rails' content_for}
  gem.summary       = %q{A Jekyll plugin kind of like Rails' content_for}
  gem.homepage      = "https://github.com/rustygeldmacher/jekyll-contentblocks"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('jekyll')
end
