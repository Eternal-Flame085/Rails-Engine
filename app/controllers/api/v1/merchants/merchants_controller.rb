class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.fetch_items(params[:id]))
  end
end
