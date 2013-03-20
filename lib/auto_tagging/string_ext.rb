module AutoTagging
  module StringExt
    def camelize(str)
      return str if str !~ /_/ && str =~ /[A-Z]+.*/
      str.split("_").map{|e| e.capitalize}.join
    end
  end
end
