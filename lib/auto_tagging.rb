require "auto_tagging/version"
require "auto_tagging/open_calais"
require "auto_tagging/alchemy"
require "auto_tagging/yahoo"
require "auto_tagging/error"

module AutoTagging
  class Main
    include OpenCalais
    include Yahoo
    include Alchemy
    include Errors

    def initialize(service, api_key=nil)
      raise InvalidServiceError unless respond_to? service
      @service = service
      @api_key = api_key
    end

    def get_tags(content = '')
      [] if content.to_s.empty?
      service = send(@service, @api_key)
      service.get_tags(content)
    end
  end
end
