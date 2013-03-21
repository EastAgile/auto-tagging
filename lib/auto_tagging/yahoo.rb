require 'auto_tagging/search_param'

module AutoTagging
  class Yahoo

    API_SITE_URL = 'http://query.yahooapis.com/v1/public/yql'

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

    def query(opts)
      %{ SELECT * FROM contentanalysis.analyze WHERE #{src_options(opts)} }
    end

    def src_options(opts)
      AutoTagging::SearchParam.url_search?(opts) ? url(opts) : text(opts)
    end

    def url(opts)
      %{ url = "#{AutoTagging::SearchParam.to_valid_url(opts.values[0])}" }
    end

    def text(opts)
      %{ text = "#{opts.gsub!('"', '\"')}" }
    end

    def uri
      URI(API_SITE_URL)
    end

    def options(content)
      {
        'q' => query(content),
        'format' => 'json',
        'max' => '50'
      }
    end
  end
end
