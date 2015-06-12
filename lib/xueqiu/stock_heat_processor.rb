class Xueqiu::StockHeatProcessor
  def process
    Stock.all.each do |stock|
      process_stock(stock)
    end
  end

  def process_stock(stock)
    puts "process stock #{stock.code}:#{stock.name}..............."
    stock_heat = StockHeatRank.new(stock: stock, date: Date.today)
    page_num = 1
    
    while (posts_data=get_posts_data(stock, page_num)).any?
      posts_data.each do |post|
        if Time.at(post['created_at'] / 1000).today?
          stock_heat.post_count += 1
        else
          stock_heat.save and return
        end
      end
      page_num += 1
      sleep 5
    end
    stock_heat.save
  end

  def get_posts_data(stock, page_num)
    conn = connection
    response = conn.get(endpoint(stock.symbol, page_num)) {|req| req.headers['Cookie'] = get_cookie }
    puts response.body
    JSON.parse(response.body)['list']
  end

  def endpoint(stock_symbol, page_num=1)
    "/statuses/search.json?count=15&comment=0&symbol=#{stock_symbol}&hl=0&source=all&sort=time&page=#{page_num}"
  end

  def connection
    @proxy_index = 0
    Faraday.new(:url => "http://xueqiu.com") do |faraday|
      faraday.request :url_encoded 
      faraday.response :logger 
      faraday.proxy proxy_server
      faraday.adapter :net_http
    end
  end

  def proxy_server
    @proxy_servers ||= begin
      require 'open-uri'
      doc = Nokogiri::HTML(open('http://pachong.org'))
      trs = doc.css("tr[data-id]")
      trs.map do |tr|
        ip = tr.css('td:nth-child(2)').text
        tr.css('td:nth-child(3)').text =~ /write\((.*)\)/
        port = eval($1.sub(/hen/, '6740').sub(/pig/, '13172').sub(/seal/, '6611').sub(/frog/, '23395').sub(/cat/, '31834').sub(/bee/, '19714').sub(/snake/, '6052')) 
        "http://#{ip}:#{port}"
      end
    end.cycle
    @proxy_servers.next
  end

  def get_cookie
    Faraday.new(:url => "http://xueqiu.com") do |faraday|
      faraday.request :url_encoded 
      faraday.response :logger 
      faraday.adapter :net_http
    end.get('/').headers['set-cookie']
  end

end
