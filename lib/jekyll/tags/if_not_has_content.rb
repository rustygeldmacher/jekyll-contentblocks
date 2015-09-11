module Jekyll
  module Tags
    class IfNotHasContent < Liquid::Block
      include ::Jekyll::ContentBlockTag
      alias_method :render_block, :render

      def render(context)
        unless block_has_content?(context)
          render_block(context)
        end
      end
    end
  end
end
