class Api::V1::Merchants::SearchController < ApplicationController
  def find_merchant
    render json: MerchantSerializer.new(SearchFacade.find_merchant(params))
  end

  def find_all
    render json: MerchantSerializer.new(SearchFacade.find_all_merchants(params))
  end
end
