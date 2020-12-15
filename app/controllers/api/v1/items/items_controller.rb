class Api::V1::Items::ItemsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Item.fetch_merchant(params[:id]))
  end
end
