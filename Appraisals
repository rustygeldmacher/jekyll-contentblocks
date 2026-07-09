# Every version runs against Ruby 2.7 in CI (Jekyll's supported minimum).
# Jekyll 3.8+ (including 4.x) is additionally tested against Ruby 3.3, 3.4 and 4.0;
# Jekyll 3.0–3.7 can't run on Ruby 3 (they use APIs removed in it: URI.escape,
# Fixnum, and positional Hash args to File.read). See .github/workflows/ci.yml.

appraise "jekyll-3.0.5" do
  gem "jekyll", "3.0.5"
end

appraise "jekyll-3.1.6" do
  gem "jekyll", "3.1.6"
end

appraise "jekyll-3.2.1" do
  gem "jekyll", "3.2.1"
end

appraise "jekyll-3.3.1" do
  gem "jekyll", "3.3.1"
end

appraise "jekyll-3.4.5" do
  gem "jekyll", "3.4.5"
end

appraise "jekyll-3.5.2" do
  gem "jekyll", "3.5.2"
end

appraise "jekyll-3.6.3" do
  gem "jekyll", "3.6.3"
end

appraise "jekyll-3.7.4" do
  gem "jekyll", "3.7.4"
end

appraise "jekyll-3.8.7" do
  gem "jekyll", "3.8.7"
end

appraise "jekyll-3.9.5" do
  gem "jekyll", "3.9.5"
  # Jekyll 3.9+ uses kramdown 2.x, which extracted the GFM parser into its own gem
  gem "kramdown-parser-gfm"
end

appraise "jekyll-3.10.0" do
  gem "jekyll", "3.10.0"
  # Jekyll 3.9+ uses kramdown 2.x, which extracted the GFM parser into its own gem
  gem "kramdown-parser-gfm"
end

# Jekyll 4 depends on kramdown-parser-gfm itself, so it isn't listed here.
appraise "jekyll-4.0.1" do
  gem "jekyll", "4.0.1"
end

appraise "jekyll-4.1.1" do
  gem "jekyll", "4.1.1"
end

appraise "jekyll-4.2.2" do
  gem "jekyll", "4.2.2"
end

appraise "jekyll-4.3.4" do
  gem "jekyll", "4.3.4"
end

appraise "jekyll-4.4.1" do
  gem "jekyll", "4.4.1"
end
