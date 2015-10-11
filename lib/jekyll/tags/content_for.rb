module Jekyll
  module Tags
    class ContentFor < Liquid::Block
      include ::Jekyll::ContentBlocks::ContentBlockTag
      alias_method :render_block, :render

      def render(context)
        content_for_block(context) << render_block(context)
        ''
      end
    end
  end
end

