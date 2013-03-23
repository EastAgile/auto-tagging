require "auto_tagging/open_calais"
require "auto_tagging/alchemy"
require "auto_tagging/yahoo"
require "auto_tagging/delicious"
require "auto_tagging/error"
require "auto_tagging/string_ext"

module AutoTagging
  include Errors

  module Config
    include AutoTagging::StringExt

    attr_accessor :services, :mains

    def services=(services)
      reset_mains
      services.each { |service| add_service(service) }
    end

    def reset_mains
      self.mains = []
    end

    private

    def add_service(service)
      klass = const(service)
      klass.api_key = api_key(service) if klass.respond_to?("api_key=")
      klass.credentials = credentials(service) if klass.respond_to?("credentials=")
      ( self.mains ||= [] ) << klass.new
    end

    #{:alchemy => "api-key"}
    def api_key(service)
      service.values[0].to_s if service.instance_of? Hash
    end

    #{:delicious => {"username" => "password"}}
    def credentials(service)      
      if service.instance_of?(Hash) && service.values[0].instance_of?(Hash)
        service.values[0]
      else
        raise AutoTagging::Errors::InvalidCredentialsError
      end
    end

    def service_name(service)
      ( service.instance_of?(Hash) ? service.keys[0] : service ).to_s
    end

    def const(service)
      AutoTagging::const_get(camelize(service_name(service)))
    rescue NameError
      raise AutoTagging::Errors::InvalidServiceError
    end
  end
end
