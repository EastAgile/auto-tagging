require 'auto_tagging/error'

module AutoTagging
  module SearchParam
    class << self
      def url_search?(opts)
        src = false
        if opts.instance_of? Hash
          if opts.keys.size == 1 && opts.keys[0].to_s.downcase == "url"
            src = true
          else
            raise AutoTagging::Errors::InvalidSearchError
          end
        end
        src
      end

      def to_valid_url(url)
        ( /http:\/\/|https:\/\// =~ url ) == 0 ? url : "http://#{url}"
      end
    end
  end
end
