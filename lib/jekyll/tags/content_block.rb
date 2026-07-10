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
        !content_block_options.include?("no-convert")
      end

      def converted_content(block_content, context)
        Array(converters_for(context)).reduce(block_content) do |content, converter|
          converter.convert(content)
        end
      end

      # Derive the document's converters straight from the render context so we
      # don't depend on the pre-render hook stashing them in the payload.
      def converters_for(context)
        site = context.registers[:site]
        extension = File.extname(context.registers[:page]["path"].to_s)
        site.converters.select { |converter| converter.matches(extension) }
      end
    end
  end
end
