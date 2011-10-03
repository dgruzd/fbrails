require "fbrails/version"
require 'net/https'
require 'json'
module Fbrails

class FailedToGet < StandardError
end


  class Auth 
    def initialize(app_id, secret, app_url)
      @app_id = app_id
      @app_url = app_url
      @secret = secret
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
      if expires != false && expires != nil && expires < Time.new
        return false
      end

      url = "https://graph.facebook.com/me/?access_token=#{token}"
      result = Fbrails.get(url)
      if result == false
        return false
      elsif result.has_key?("id")
        return true
      else
        return nil
      end
        
    end

    def redirect_url
      if !@app_id.blank? && !@app_url.blank?
        "https://www.facebook.com/dialog/oauth?client_id=#{@app_id}&redirect_uri=#{@app_url}"
      else
        "" 
      end
    end
end

  class Graph
    def initialize(token)
      @token = token
    end



    def me
      url = "https://graph.facebook.com/me/?access_token=#{@token}"
      Fbrails.get(url)
    end
  end
  
  
  def self.get(url,raw = false)
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
