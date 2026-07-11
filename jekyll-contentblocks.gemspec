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
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/) - ["Gemfile.lock"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # Jekyll 3.0–3.7 rely on APIs removed in Ruby 3, so 2.7 is the effective floor.
  gem.required_ruby_version = ">= 2.7.0"

  # Supports the Jekyll 3.x and 4.x series; excludes the announced-breaking 5.x.
  gem.add_dependency('jekyll', '>= 3.0', '< 5.0')
end
