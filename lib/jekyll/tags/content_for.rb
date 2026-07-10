module Jekyll
  module Tags
    class ContentFor < Liquid::Block
      include ::Jekyll::ContentBlocks::ContentBlockTag
      alias_method :render_block, :render

      def render(context)
        data, body = split_front_matter(render_block(context))
        content_for_block(context) <<
          {
            "raw" => body,
            "content" => converted_content(body, context),
            "data" => data
          }
        ""
      end

      private

      def split_front_matter(rendered)
        if rendered.lstrip =~ Jekyll::Document::YAML_FRONT_MATTER_REGEXP
          [SafeYAML.load(Regexp.last_match(1)) || {}, $POSTMATCH]
        else
          [{}, rendered]
        end
      end
    end
  end
end
