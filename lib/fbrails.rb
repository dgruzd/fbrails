require "fbrails/version"
require 'net/https'
require 'json'

module Fbrails

class FailedToGet < StandardError
end

  def get (url,raw = false)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host,uri.port)
      http.use_ssl = true if url =~ /^https/
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE if url =~ /^https/
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

  def self.put(url)
  
  end

require 'fbrails/auth'

require 'fbrails/graph'

end
