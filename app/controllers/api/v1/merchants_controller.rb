class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    merchant = Merchant.where(id: params[:id]).first

    if merchant
      render json: MerchantSerializer.new(merchant)
    else
      render json: ErrorSerializer.error
    end
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.id != nil
      render json: MerchantSerializer.new(merchant)
    else
      render json: ErrorSerializer.error("Missing attributes")
    end
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
