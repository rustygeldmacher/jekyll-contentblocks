module Jekyll
  module Convertible
    alias_method :do_layout_orig, :do_layout

    def do_layout(payload, layouts)
      payload['converters'] = converters_for_content_block
      payload['contentblocks'] = {}
      do_layout_orig(payload, layouts)
    end

    private

    def converters_for_content_block
      if jekyll_version_less_than?('2.3.0')
        [converter]
      else
        converters.reject do |converter|
          converter.class == Jekyll::Converters::Identity
        end
      end
    end

    def jekyll_version_less_than?(version)
      Gem::Version.new(Jekyll::VERSION) < Gem::Version.new(version)
    end
  end
end
