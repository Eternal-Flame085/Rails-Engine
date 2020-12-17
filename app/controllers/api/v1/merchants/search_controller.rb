class Api::V1::Merchants::SearchController < ApplicationController
  def find_merchant
    render json: MerchantSerializer.new(SearchFacade.find_merchant(params))
  end

  def find_all
    render json: MerchantSerializer.new(SearchFacade.find_all_merchants(params))
  end

  def most_revenue
    render json: MerchantSerializer.new(SearchFacade.most_revenue(params))
  end

  def most_items
    render json: MerchantSerializer.new(SearchFacade.most_items(params))
  end

  def merchant_revenue
    render json: RevenueSerializer.revenue(SearchFacade.merchant_revenue(params))
  end
end
