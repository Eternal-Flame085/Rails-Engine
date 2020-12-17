class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  def destroy
    Merchant.delete(params[:id])
  end

  def revenue_accross_dates
    render json: RevenueSerializer.revenue(SearchFacade.revenue_accross_dates(params))
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
