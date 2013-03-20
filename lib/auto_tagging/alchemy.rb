require 'alchemy_api'

module AutoTagging
  module Alchemy

    class Main
      class << self
        attr_accessor :api_key

        def api_key=(api_key)
          AlchemyAPI.key = api_key
        end
      end

      def get_tags(content)
        tags = AlchemyAPI.search(:keyword_extraction, :text => content) || []
        tags.map { |tag| tag["text"] }
      end
    end
  end
end
