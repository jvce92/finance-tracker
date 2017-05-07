class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.new_from_lookup(ticker_symbol)
    lookup_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless lookup_stock.name

    new_stock = new(ticker: lookup_stock.symbol, name: lookup_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def price
    begin
      closing_price = StockQuote::Stock.quote(ticker).close
    rescue
      closing_price = nil
    end
    return "#{closing_price} (Closing)" if closing_price

    begin
      opening_price = StockQuote::Stock.quote(ticker).open
    rescue
      opening_price = nil
    end
    return "#{opening_price} (Opening)" if opening_price
    'Unavailable'
  end

end
