class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: MerchantSerializer.format_merchants(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.format_merchant(merchant)
  end

  def create
    merchant = Merchant.create(merchant_params)
    render json: MerchantSerializer.format_merchant(merchant)
  end

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render json: MerchantSerializer.format_merchant(merchant)
  end

  def destroy
    render json: Merchant.delete(params[:id])
  end

  def items
    items = Merchant.fetch_items(params[:merchant_id])
    render json: ItemSerializer.format_items(items)
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
