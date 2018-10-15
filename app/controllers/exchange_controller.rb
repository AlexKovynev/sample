class ExchangeController < ApplicationController
  def list
    render json: Exchange.all.pluck(:title).to_json
  end

  def show_info
    exchange_data = Exchange.where(title: params[:title]).first.try(:data)
    if exchange_data.nil?
      render status: 404
    else
      render json: exchange_data
    end
  end

  def markets
    exchange_markets = Exchange.where(title: params[:title]).first.try(:markets)
    if exchange_markets.nil?
      render status: 404
    else
      render json: exchange_markets
    end
  end

end
