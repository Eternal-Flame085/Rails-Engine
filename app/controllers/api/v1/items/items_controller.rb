class Api::V1::Items::ItemsController < ApplicationController
  def index
    merchant = Item.fetch_merchant(params[:id])
    render json: MerchantSerializer.new(merchant)
  end
end
