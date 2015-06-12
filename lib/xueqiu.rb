module Xueqiu
  def self.connection
    Faraday.new(:url => "http://xueqiu.com") do |faraday|
      faraday.request :url_encoded 
      faraday.response :logger 
      faraday.adapter :net_http_persistent
    end
  end
end

