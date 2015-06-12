class Tonghuashun::StocksFetcher
  def self.fetch
    page_num = 1
    while (data = stock_data(page_num)).any?
      data.each do |stock_json|
        Stock.where(code: stock_json['stockcode']).first_or_create do |stock|
          stock.name = stock_json['stockname']
        end
      end
      page_num += 1 
    end
  end

  def self.stock_data(page_num)
    response = connection.get(endpoint(page_num))
    JSON.parse(response.body)['data']
  end

  def self.endpoint(page_num=1)
    "/interface/stock/fl/zdf/desc/#{page_num}/hsa/quote"
  end

  def self.connection
    Faraday.new(:url => "http://q.10jqka.com.cn") do |faraday|
      faraday.request :url_encoded 
      faraday.response :logger 
      faraday.adapter :net_http_persistent
    end
  end
end
