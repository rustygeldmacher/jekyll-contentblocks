module Jekyll
  module Tags
    class ContentBlock < Liquid::Tag
      include ::Jekyll::ContentBlockTag

      def render(context)
        block_content = content_for_block(context).join
        converters = context.environments.first['converters']
        Array(converters).reduce(block_content) do |content, converter|
          converter.convert(content)
        end
      end
    end
  end
end

