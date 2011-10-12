module Fbrails  
  class Graph
    def initialize(token)
      @token = token
    end

    def me
      url = "https://graph.facebook.com/me/?access_token=#{@token}"
      Fbrails.get(url)
    end
    
        
  end
end