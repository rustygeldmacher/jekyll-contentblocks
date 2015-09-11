module Jekyll
  module ContentBlockTag
    def initialize(tag_name, block_name, tokens)
      super
      @block_name = get_content_block_name(tag_name, block_name)
    end

    private

    def get_content_block_name(tag_name, block_name)
      block_name = (block_name || '').strip
      if block_name == ''
        raise SyntaxError.new("No block name given in #{tag_name} tag")
      end
      block_name
    end

    def block_has_content?(context)
      block_content = content_for_block(context).join
      !(block_content.nil? || block_content.empty?)
    end

    def content_for_block(context)
      context.environments.first['contentblocks'] ||= {}
      context.environments.first['contentblocks'][@block_name] ||= []
    end
  end
end
