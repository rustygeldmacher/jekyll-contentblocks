module Jekyll
  module Tags
    class IfHasContent < Liquid::Block
      include ::Jekyll::ContentBlocks::ContentBlockTag
      alias_method :render_block, :render

      def render(context)
        if block_has_content?(context)
          render_block(context)
        end
      end
    end
  end
end
