module Jekyll
  module Tags
    class ContentFor < Liquid::Block
      include ::Jekyll::ContentBlocks::Common
      alias_method :render_block, :render

      def initialize(tag_name, block_name, tokens)
        super
        @block_name = get_content_block_name(tag_name, block_name)
      end

      def render(context)
        content_for_block(context) << render_block(context)
        ''
      end
    end
  end
end

