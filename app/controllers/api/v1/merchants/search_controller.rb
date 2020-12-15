class Api::V1::Merchants::SearchController < ApplicationController
  def find_merchant
    attribute = params.keys.first
    render json: MerchantSerializer.new(Merchant.where("#{attribute} ILIKE ?", "%#{params[attribute]}%").first)
  end

  def find_all
    attribute = params.keys.first
    render json: MerchantSerializer.new(Merchant.where("#{attribute} ILIKE ?", "%#{params[attribute]}%"))
  end
end
