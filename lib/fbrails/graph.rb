module Fbrails  
  class Graph

    URL = "https://graph.facebook.com/"
  
    def initialize(token)
      @token = token
    end



    def friends
      result = []
      friends = Fbrails.get(URL+"me"+"/"+"friends"+access_token)
      loop do
        if friends.has_key?("paging") && friends["paging"].has_key?("next")
          unless friends["data"].blank?
            friends["data"].each do |fr|
              fr["id"] = fr["id"].to_i
              result << fr
            end
          end
        else
          return result
        end
      friends = Fbrails.get(friends["paging"]["next"])
      end
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
      Fbrails.get(URL+url+access_token)
    end
    
    
  end
end
