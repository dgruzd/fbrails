require 'rubygems'
require "fbrails/version"
require 'net/https'
require 'json'
require 'httpclient'


module Fbrails

class FailedToGet < StandardError
end
class TokenExpired < StandardError
end
    def self.get (url,raw = false)
#      uri = URI.parse(url)
#      http = Net::HTTP.new(uri.host,uri.port)
#      http.use_ssl = true if url =~ /^https/
#      http.verify_mode = OpenSSL::SSL::VERIFY_NONE if url =~ /^https/
#      request = Net::HTTP::Get.new(uri.request_uri)
#      resp = http.request(request).body
    resp = ::HTTPClient.new.get_content(url)
    if raw
      return resp
    end
    result = JSON.parse(resp)
    if result.has_key?("error")
#if result["error"].has_key?("type") && result["error"]["type"] == "OAuthException"
#        raise TokenExpired, "Token expired"
#      else
        raise FailedToGet, "Failed to get"
#      end
    else
      return result
    end

    #rescue HTTPClient::BadResponseError
    #  raise TokenExpired, "Token expired"
    end

  def self.put(url, data)
#url = URI.parse(url)
    begin
      response = RestClient.put url, data, {:content_type => :json}
    end
      object = JSON.parse(response)
  end   





  

require 'fbrails/auth'

require 'fbrails/graph'

end
