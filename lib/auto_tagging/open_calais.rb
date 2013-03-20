require "net/http"
require "json"

module AutoTagging
  class OpenCalais
    API_SITE_URL = 'api.opencalais.com'
    API_PAGE_URL = '/tag/rs/enrich'

    class << self
      attr_accessor :api_key
    end

    def get_tags(content)
      res = nil
      Net::HTTP.start(API_SITE_URL) do |http|
        req = Net::HTTP::Post.new(API_PAGE_URL)
        req.initialize_http_header(options)
        req.body = content
        res = http.request(req)
      end

      tags = JSON.parse(res.body).values.map { |value| value["name"] }.compact if res && res.code == "200"
      tags || []
    end

    private

    def options
      @options ||= {
        'x-calais-licenseID' => OpenCalais.api_key,
        'content-type' => 'text/raw',
        'outputFormat' => 'Application/JSON',
        'calculateRelevanceScore' => 'false',
        'enableMetadataType' => 'SocialTags'
      }
    end
  end
end
