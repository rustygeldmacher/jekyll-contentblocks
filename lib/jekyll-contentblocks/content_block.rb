module Jekyll
  module Tags
    class ContentBlock < Liquid::Tag
      include ::Jekyll::ContentBlocks::Common

      def initialize(tag_name, block_name, tokens)
        super
        @block_name = get_content_block_name(tag_name, block_name)
      end

      def render(context)
        converter = context.environments.first['converter']
        content_for_block(context).map { |c| converter.convert(c || '') }.join
      end
    end
  end
end

