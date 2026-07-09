source 'https://rubygems.org'

# No `ruby` pin here on purpose: Appraisal copies this Gemfile's directives into
# every generated gemfiles/*.gemfile, and those run across a Ruby matrix (all
# versions on 2.7, plus Jekyll 3.8+ on 3.3). See .github/workflows/ci.yml and Appraisals.
gem 'jekyll', '~> 3.8.0'
gem 'rexml'
gem 'appraisal', '~> 2.5.0'

gem 'pry'
gem 'rspec', '~> 3.13.0'
gem 'nokogiri'

# Declared here (not in the gemspec) so they are not forced on consumers of the
# gem. They silence "loaded from the standard library" warnings that Jekyll's own
# deps (safe_yaml, liquid) trigger on Ruby 3.3+, where these leave the default gems.
gem 'base64'
gem 'bigdecimal'
gem 'csv'

gemspec
