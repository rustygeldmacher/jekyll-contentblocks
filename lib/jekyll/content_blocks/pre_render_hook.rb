module Jekyll
  module ContentBlocks
    class PreRenderHook
      def self.call(document, payload)
        # Reset the per-document block store. Converters are derived on demand by
        # the contentblock tag from the render context, so they aren't stashed here.
        payload["contentblocks"] = {}
      end
    end
  end
end
