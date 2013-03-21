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
    end
  end
end
