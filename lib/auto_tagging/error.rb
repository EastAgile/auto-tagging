module AutoTagging
  module Errors
    class InvalidServiceError < StandardError
      def initialize(msg = "Please specify a valid tagging service")
        super(msg)
      end
    end

    class NilContentError < StandardError
      def initialize(msg = "Content is required")
        super(msg)
      end
    end

    class NoServiceConfigurationError < StandardError
      def initialize(msg = "Please configure at lease 1 tagging service")
        super(msg)
      end
    end
  end
end
