module Jekyll
  module ContentBlocks
    module ContentBlockTag
      attr_accessor :content_block_name
      attr_accessor :content_block_options

      def initialize(tag_name, markup, tokens)
        super
        parse_options(markup)
        if content_block_name == ''
          raise SyntaxError.new("No block name given in #{tag_name} tag")
        end
      end

      private

      def parse_options(markup)
        options = (markup || '').split(' ').map(&:strip)
        self.content_block_name = options.shift
        self.content_block_options = options
      end

      def block_has_content?(context)
        block_content = content_for_block(context).join
        !(block_content.nil? || block_content.empty?)
      end

      def content_for_block(context)
        environment = context.environments.first
        environment['contentblocks'] ||= {}
        environment['contentblocks'][content_block_name] ||= []
      end
    end
  end
end
