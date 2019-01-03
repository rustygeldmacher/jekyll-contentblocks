module Jekyll
  module Tags
    class ContentFor < Liquid::Block
      include ::Jekyll::ContentBlocks::ContentBlockTag
      alias_method :render_block, :render

      def render(context)
      
        rendered_block = render_block(context)
        
        if rendered_block =~ Jekyll::Document::YAML_FRONT_MATTER_REGEXP
          rendered_block = $POSTMATCH
          data = SafeYAML.load(Regexp.last_match(1))
          
        elsif rendered_block.lstrip =~ Jekyll::Document::YAML_FRONT_MATTER_REGEXP
          rendered_block = $POSTMATCH
          data = SafeYAML.load(Regexp.last_match(1))
          
        end

        content_for_block(context) << rendered_block
        context['page']['contentblocks'] ||= {}
        context['page']['contentblocks'][content_block_name] ||= []
        context['page']['contentblocks'][content_block_name] << { 'content' => converted_content(rendered_block, context), 'data' => data }
        
        ''
      end
    end
  end
end

