module Jekyll
  module Tags
    class ContentBlock < Liquid::Tag
      include ::Jekyll::ContentBlocks::ContentBlockTag

      def render(context)
        block_content = raw_block_content(context)
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
    end
  end
end
