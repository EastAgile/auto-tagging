require 'alchemy_api'
require 'auto_tagging/search_param'

module AutoTagging
  class Alchemy
    class << self
      attr_accessor :api_key

      def api_key=(api_key)
        AlchemyAPI.key = api_key
      end
    end

    def get_tags(opts)
      tags = AlchemyAPI.search(:keyword_extraction, src_options(opts)) || []
      tags.map { |tag| tag["text"] }
    end

    def src_options(opts)
      AutoTagging::SearchParam.url_search?(opts) ? opts : {:text => opts}
    end
  end
end
