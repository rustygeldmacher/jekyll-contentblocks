module Jekyll
  module Tags
    class ContentBlock < Liquid::Tag
      include ::Jekyll::ContentBlocks::Common

      def initialize(tag_name, block_name, tokens)
        super
        @block_name = get_content_block_name(tag_name, block_name)
      end

      def render(context)
        block_content = content_for_block(context).join
        converters = context.environments.first['converters']
        converters.reduce(block_content) do |content, converter|
          converter.convert(content)
        end
      end
    end
  end
end

