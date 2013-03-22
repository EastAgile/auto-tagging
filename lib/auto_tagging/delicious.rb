require 'net/http'
require 'auto_tagging/search_param'
require 'rexml/document'

module AutoTagging
	class Delicious
		USERNAME = 'auto_tagging_gem'
		PASSWORD = 'notsecure'
		
		API_HOST = 'api.del.icio.us'

		def get_tags(opts)			
			AutoTagging::SearchParam.url_search?(opts) ? api_request(url(opts)) : []
		end

		def api_request(url)
			wait_for_next_valid_request
		  http = Net::HTTP.new(API_HOST, 443)
		  http.use_ssl = true			  
		  http.start do |http|
		    req = Net::HTTP::Get.new("/v1/posts/suggest?url=#{url}", {"User-Agent" => "auto_tagging ruby gem"})
		    req.basic_auth(USERNAME, PASSWORD)
		    parse_response(http.request(req))
		  end
		rescue SocketError => e
			[]
		end

		def parse_response(response)			
			xml = response.body		  

		  REXML::Document.new(xml).root.elements.map { |e| e.attributes['tag'] }
		rescue
		  []
		end

		def wait_for_next_valid_request
			sleep 1
		end

		def url(opts)
			"#{URI.encode(AutoTagging::SearchParam.to_valid_url(opts[:url]))}"			
		end
	end
end