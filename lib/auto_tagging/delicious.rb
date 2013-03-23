require 'net/http'
require 'auto_tagging/search_param'
require 'rexml/document'

module AutoTagging
	class Delicious		
		API_HOST = 'api.del.icio.us'
		API_PAGE = '/v1/posts/suggest'

		class << self
			attr_accessor :username, :password

			def credentials=(credentials)
				self.username = credentials.keys[0]
				self.password = credentials.values[0]
			end
		end		

		def get_tags(opts)			
			AutoTagging::SearchParam.url_search?(opts) ? api_request(url(opts)) : []
		end

		private

		def api_request(url)
			wait_for_next_valid_request

		  prepared_http.start do |http|
		    req = Net::HTTP::Get.new(api_request_url(url), user_agent)
		    req.basic_auth(self.class.username, self.class.password)
		    parse_response(http.request(req))
		  end
		rescue SocketError => e
			[]
		end

		def prepared_http
			http = Net::HTTP.new(API_HOST, 443)
		  http.use_ssl = true		  
		  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		  http
		end

		def api_request_url(url)
			"#{API_PAGE}?url=#{url}"	
		end

		def user_agent
			{"User-Agent" => "auto_tagging ruby gem"}	
		end

		def parse_response(response)		
			if response.code == "401"							
				raise AutoTagging::Errors::InvalidCredentialsError
			else
				begin
					REXML::Document.new(response.body).root.elements.map { |e| e.attributes['tag'] }
				rescue
					[]	
				end	
			end
		end

		def wait_for_next_valid_request
			sleep 1
		end

		def url(opts)
			"#{URI.encode(AutoTagging::SearchParam.to_valid_url(opts[:url]))}"			
		end
	end
end