require "auto_tagging/version"
require "auto_tagging/open_calais"
require "auto_tagging/error"

module AutoTagging
  class Main
    include OpenCalais
    include Errors

    def initialize(service, api_key)
      raise InvalidServiceError, 'Please specify a valid tagging service' unless respond_to? service
      @service = service
      @api_key = api_key
    end

    def get_tags(content)
      service = send(@service, @api_key)
      service.get_tags(content)
    end
  end
end
