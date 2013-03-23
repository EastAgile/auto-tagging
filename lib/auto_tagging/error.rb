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

    class InvalidSearchError < StandardError
      def initialize(msg = "Invalid search options")
        super(msg)
      end
    end

    class InvalidCredentialsError < StandardError
      def initialize(msg = "Delicious service is configured without credentials")
        super(msg)
      end
    end
  end
end
