require "fbrails/version"
require 'net/https'
require 'json'

module Fbrails

class FailedToGet < StandardError
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

require 'fbrails/auth'

require 'fbrails/graph'

end
