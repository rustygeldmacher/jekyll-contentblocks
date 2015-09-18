module Jekyll
  class Renderer
    alias_method :render_liquid_orig, :render_liquid

    def render_liquid(content, payload, info, path = nil)
      payload['converters'] ||= converters
      payload['contentblocks'] ||= {}
      render_liquid_orig(content, payload, info, path)
    end
  end
end
