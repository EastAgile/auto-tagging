require "net/http"
require "json"

module AutoTagging
  module OpenCalais
    class Main
      API_SITE_URL = 'api.opencalais.com'
      API_PAGE_URL = '/tag/rs/enrich'

      def initialize(api_key)
        @api_key = api_key
      end

      def get_tags(content)
        res = nil
        Net::HTTP.start(API_SITE_URL) do |http|
          req = Net::HTTP::Post.new(API_PAGE_URL)
          req.initialize_http_header(options)
          req.body = content
          res = http.request(req)
        end

        if res && res.code == "200"
          JSON.parse(res.body).values.map { |value| value["name"] }.compact
        else
          []
        end
      end

      private

      def options
        @options ||= {
          'x-calais-licenseID' => @api_key,
          'content-type' => 'text/raw',
          'outputFormat' => 'Application/JSON',
          'calculateRelevanceScore' => 'false',
          'enableMetadataType' => 'SocialTags'
        }
      end
    end

    def open_calais(api_key)
      Main.new(api_key)
    end
  end
end
