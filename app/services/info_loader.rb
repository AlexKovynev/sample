class InfoLoader
  attr_accessor :my_exchanges, :rest_uri

  def initialize(rest_uri = 'http://localhost:3000')
    @rest_uri = rest_uri
    @my_exchanges = {}
  end

  def load_all
    exchanges = load_exchanges
    return if exchanges.nil?

    exchanges.each do |title|
      process_exchange(title)
    end
    clear
    @my_exchanges = {}
  end

  private

  def process_exchange(title)
    data = load_exchange_data(title)
    return if data.nil?

    uid = load_exchange_uid(title)
    return if uid.nil?

    my_exchange = save_exchange(data, title, uid)

    markets = load_markets(title, uid)
    return if markets.nil?

    markets.each do |market|
      save_market(market, my_exchange)
    end
  end

  def save_market(market, my_exchange)
    my_market = my_exchange.markets.where(uid: market['id']).first_or_initialize
    my_market.data = market
    @my_exchanges[my_exchange.title][market['id']] = true
    my_market.save!
  end

  def save_exchange(data, title, uid)
    my_exchange = Exchange.where(title: title).first_or_initialize
    my_exchange.uid = uid
    my_exchange.data = data
    my_exchange.save!
    @my_exchanges[title] = {}
    my_exchange
  end

  def load_exchanges
    res = Net::HTTP.get_response(URI("#{@rest_uri}/exchanges"))
    return nil unless res.is_a?(Net::HTTPSuccess)

    JSON.parse(res.body)
  end

  def load_markets(title,uid)
    uri_markets = URI("#{@rest_uri}/exchanges/#{title}/#{uid}/fetchMarkets")
    res_markets = Net::HTTP.post_form(uri_markets, {})
    return nil unless res_markets.is_a?(Net::HTTPSuccess)

    JSON.parse(res_markets.body)
  end

  def load_exchange_data(title)
    uri_exchange = URI("#{@rest_uri}/exchanges/#{title}")
    res_data = Net::HTTP.post_form(uri_exchange, {})
    return nil unless res_data.is_a?(Net::HTTPSuccess)

    JSON.parse(res_data.body)
  end

  def load_exchange_uid(title)
    res_uids = Net::HTTP.get_response(URI("#{@rest_uri}/exchanges/#{title}"))
    return nil unless res_uids.is_a?(Net::HTTPSuccess)

    uids = JSON.parse(res_uids.body)
    return nil unless uids.length.positive?

    uids[0]
  end

  def clear
    Exchange.all.each do |exchange|
      my_exchange_markets = @my_exchanges.fetch(exchange.title)
      if my_exchange_markets.nil?
        exchange.destroy!
      else
        exchange.markets.each do |market|
          market.destroy! unless my_exchange_markets[market.uid]
        end
      end
    end
  end
end