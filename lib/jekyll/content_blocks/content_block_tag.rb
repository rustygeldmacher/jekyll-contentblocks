module Jekyll
  module ContentBlocks
    module ContentBlockTag
      attr_accessor :content_block_name
      attr_accessor :content_block_options

      def initialize(tag_name, markup, tokens)
        super
        parse_options(markup)
        if content_block_name == ""
          raise SyntaxError.new("No block name given in #{tag_name} tag")
        end
      end

      private

      def parse_options(markup)
        options = (markup || "").split(" ").map(&:strip)
        self.content_block_name = options.shift
        self.content_block_options = options
      end

      def block_has_content?(context)
        !raw_block_content(context).empty?
      end

      # Write accessor for the contentfor tag: returns the block's array, creating
      # it if needed. Each stored block is a hash: "raw" (the block body), "content"
      # (that body converted) and "data" (its own front matter). The store is
      # exposed to layouts as contentblocks.<name> so they can be looped over.
      def content_for_block(context)
        store = (context.environments.first["contentblocks"] ||= {})
        store[content_block_name] ||= []
      end

      # Read-only view — does NOT create an empty entry. Reading a never-defined
      # block therefore leaves contentblocks.<name> nil (falsy) rather than an
      # empty array (which Liquid would treat as truthy).
      def blocks_for(context)
        (context.environments.first["contentblocks"] || {})[content_block_name] || []
      end

      def raw_block_content(context)
        blocks_for(context).map { |block| block["raw"] }.join
      end

      # Convert content with the document's converters, derived from the render
      # context (so we don't depend on the pre-render hook stashing them).
      def converted_content(content, context)
        Array(converters_for(context)).reduce(content) do |result, converter|
          converter.convert(result)
        end
      end

      def converters_for(context)
        site = context.registers[:site]
        extension = File.extname(context.registers[:page]["path"].to_s)
        site.converters.select { |converter| converter.matches(extension) }
      end
    end
  end
end
