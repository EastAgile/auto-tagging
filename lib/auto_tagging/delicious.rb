require 'net/http'
require 'auto_tagging/search_param'
require 'rexml/document'

module AutoTagging
	class Delicious
		USERNAME = 'auto_tagging_gem'
		PASSWORD = 'notsecure'
		
		API_HOST = 'api.del.icio.us'
		API_PAGE = '/v1/posts/suggest'

		def get_tags(opts)			
			AutoTagging::SearchParam.url_search?(opts) ? api_request(url(opts)) : []
		end

		private

		def api_request(url)
			wait_for_next_valid_request

		  prepared_http.start do |http|
		    req = Net::HTTP::Get.new(api_request_url(url), user_agent)
		    req.basic_auth(USERNAME, PASSWORD)
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
		  REXML::Document.new(response.body).root.elements.map { |e| e.attributes['tag'] }
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

#ssl certificate ( Chung chi ssl ) was created uniquely for each website
#steps
#browser request server for ssl certificate
#server send back its ssl certificate
#browser then verify for the validity of certificate by sending this certificate to GLobalSign or Verisign
#browser then send back digital number to encode and decode


#another steps
#browser make request to a secure url (https)
#web server sends its public key with its certificate
#browser then check for its validity (issued by a trusted party, still valid, related to site contacted)
#browser then use public key to encrypt a random symmetric encryption key and sends it to the server
#The web server decrypts the symmetric encryption key using its private key and uses the symmetric key to decrypt the URL and http data.

#public key => send out to everybody , let them encrypt some data with this public key and send back the encrypted data
#private key => use to decrypt the encrypted data which is encrypted by the sent out public key