module Jekyll
  module ContentBlocks
    class PreRenderHook
      def self.call(document, payload)
        payload['converters'] = document.site.converters.select do |converter|
          file_extension = File.extname(document.path)
          converter.matches(file_extension)
        end
        payload['contentblocks'] = {}
      end
    end
  end
end
