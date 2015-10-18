module Jekyll
  module Tags
    class ContentBlock < Liquid::Tag
      include ::Jekyll::ContentBlocks::ContentBlockTag

      def render(context)
        block_content = content_for_block(context).join
        if convert_content?
          converted_content(block_content, context)
        else
          block_content
        end
      end

      private

      def convert_content?
        !content_block_options.include?('no-convert')
      end

      def converted_content(block_content, context)
        converters = context.environments.first['converters']
        Array(converters).reduce(block_content) do |content, converter|
          converter.convert(content)
        end
      end
    end
  end
end
