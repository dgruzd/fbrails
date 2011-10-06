module Fbrails  
  class Graph
    def initialize(token)
      @token = token
    end

    def get_object(obj = "")
      url = "https://graph.facebook.com/me/#{obj}?access_token=#{@token}"
      Fbrails.get(url)
    end


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




  end
end
