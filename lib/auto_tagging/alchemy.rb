require 'alchemy_api'

module AutoTagging
  module Alchemy

    class Main
      def initialize(api_key)
        AlchemyAPI.key = api_key
      end

      def get_tags(content)
        tags = AlchemyAPI.search(:keyword_extraction, :text => content) || []
        tags.map { |tag| tag["text"] }
      end
    end

    def alchemy(api_key)
      Main.new(api_key)
    end
  end
end
