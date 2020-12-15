class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    items = Merchant.fetch_items(params[:id])
    render json: ItemSerializer.new(items)
  end
end
