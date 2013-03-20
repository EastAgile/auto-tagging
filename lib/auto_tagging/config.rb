require "auto_tagging/open_calais"
require "auto_tagging/alchemy"
require "auto_tagging/yahoo"
require "auto_tagging/error"
require "auto_tagging/string_ext"

module AutoTagging
  include Errors

  module Config
    attr_accessor :services, :mains
    include AutoTagging::StringExt

    def services=(services)
      reset_mains
      services.each { |service| add_service(service) }
    rescue
      raise AutoTagging::Errors::InvalidServiceError
    end

    def reset_mains
      self.mains = []
    end

    private
    def add_service(service)
      service_name = service.instance_of?(Hash) ? service.keys[0] : service
      const = AutoTagging::const_get(camelize(service_name.to_s))::Main
      const.api_key = service.values[0].to_s if service.instance_of? Hash
      self.mains << const.new
    end
  end
end