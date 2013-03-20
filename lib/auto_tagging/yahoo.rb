module AutoTagging
  module Yahoo
    CONSUMER_KEY = 'dj0yJmk9QkIxb2NxYTRoOTB4JmQ9WVdrOU5UWlJUVUkyTXpBbWNHbzlNVGd3T1RBNU1EazJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD03Zg--'
    CONSUMER_SECRET = '76feeb4a1ee8037e3dda6b4cf8df6e60ab88140f'
    API_SITE_URL = 'http://query.yahooapis.com/v1/public/yql'

    class Main
      def get_tags(content)
        res = Net::HTTP.post_form(uri, options(content))
        json_res = JSON.parse(res.body)
        tags = parse_response(res) if (json_res["query"]["count"] > 0)
        tags || []
      end

      private

      def parse_response(res)
        results = JSON.parse(res.body)["query"]["results"]
        categories(results).concat entities(results)
      end

      def categories(results)
        ( [] << results["yctCategories"]["yctCategory"] ).flatten.map { |c| c["content"] }
      rescue
        []
      end

      def entities(results)
        ( [] << results["entities"]["entity"] ).flatten.map { |e| e["text"]["content"] }
      rescue
        []
      end

      def query(content)
        %{ SELECT * FROM contentanalysis.analyze WHERE text = "#{content}" }
      end

      def uri
        URI(API_SITE_URL)
      end

      def options(content)
        content.gsub!('"', '\"')
        {
          'q' => query(content),
          'format' => 'json',
          'max' => '50'
        }
      end
    end
  end
end
