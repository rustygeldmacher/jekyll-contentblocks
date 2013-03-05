module Jekyll
  module Convertible
    alias_method :do_layout_orig, :do_layout

    def do_layout(payload, layouts)
      # The contentblock tags needs access to the converter to process it while rendering.
      payload['converter'] = self.converter
      do_layout_orig(payload, layouts)
    end
  end
end
