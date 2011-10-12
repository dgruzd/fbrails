module Fbrails  
  class Graph

    URL = "https://graph.facebook.com/"
  
    def initialize(token)
      @token = token
    end

    # def get_object(obj = "")
    #   url = "https://graph.facebook.com/me/#{obj}?access_token=#{@token}"
    #   Fbrails.get(url)
    # end

    #graph.get_picture(ID,TYPE)
    #TYPE can be square (50x50), small (50 pixels wide, variable height),  normal (100 pixels wide, variable height), large (about 200 pixels wide, variable height)
   def self.get_picture(id,type=nil)
    first = "http://graph.facebook.com/#{id}/picture"
      if type.blank?
        return first 
      elsif type == 'square' || type == 'small' || type == 'normal' || type == 'large'
        return first + "?type=#{type}"
      end
    end

    # Fbrails::Graph.me_books

    def method_missing (method)  
      call(method)  
    end
    
    def access_token
      "?access_token=#{@token}"
    end

    def call (method)
      url = method.to_s.split("_").join("/")
      get(URL+url+access_token)
    end
    
    def get (url,raw = false)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host,uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      resp = http.request(request)
      if raw
        return resp.body
      end
      result = JSON.parse(resp.body)
      if result.has_key?("error")
        raise FailedToGet, "Failed to get, probably token expired"
      else
        return result
      end
    end
    
  end
end
