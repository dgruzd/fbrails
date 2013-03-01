module Fbrails
  class Auth 
    def initialize(app_id, secret, app_url)
      @app_id = app_id
      @app_url = app_url
      @secret = secret
    end

    def redirect_url(*scope)
      if !@app_id.blank? && !@app_url.blank?
        "https://www.facebook.com/dialog/oauth?client_id=#{@app_id}&redirect_uri=#{@app_url}#{'&scope='+scope.join(',') unless scope.blank?}"
      else
        "" 
      end
    end
    
    def token(code)
      url = "https://graph.facebook.com/oauth/access_token?client_id=#{@app_id}&redirect_uri=#{@app_url}&client_secret=#{@secret}&code=#{code}"
      resp = Fbrails.get(url,true)
      if resp.include?("access_token=")
        hash = Hash.new
        expire = resp.scan(/\d+/).last.to_i 
        hash[:expires] = Time.new + expire 
        hash[:token] = resp.gsub(/access_token=/, "").gsub(/&expires=\d+/,"")
        return hash
      else
        nil
      end
    end 
    
    def self.token_valid?(token,expires = false)
      if expires.class == Time && expires < Time.new
        return false
      end

      url = "https://graph.facebook.com/me/?access_token=#{token}"
      begin
        result = Fbrails.get(url)
      rescue
        return false
      end
      if result == false
        return false
      elsif result.has_key?("id")
        return true
      else
        return nil
      end
        
    end
  end
end
