module Jekyll
  module ContentBlocks
    module Common
      # Extracts and verified the content block's name
      def get_content_block_name(tag_name, block_name)
        block_name = (block_name || '').strip
        if block_name == ''
          raise SyntaxError.new("No block name given in #{tag_name} tag")
        end
        block_name
      end

      # Gets the storage space for the content block
      def content_for_block(context)
        context.environments.first['contentblocks'] ||= {}
        context.environments.first['contentblocks'][@block_name] ||= []
      end
    end
  end
end
