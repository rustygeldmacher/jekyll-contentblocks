module Jekyll
  module ContentBlocks
    module Common
      def get_content_block_name(tag_name, block_name)
        block_name = (block_name || '').strip
        if block_name == ''
          raise SyntaxError.new("No block name given in #{tag_name} tag")
        end
        block_name
      end

      def content_for_block(context)
        context.environments.first['contentblocks'] ||= {}
        context.environments.first['contentblocks'][@block_name] ||= []
      end
    end
  end
end
