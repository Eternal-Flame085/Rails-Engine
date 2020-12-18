class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    item = Item.where(id: params[:id]).first

    if item
      render json: ItemSerializer.new((item))
    else
      render json: ErrorSerializer.error
    end
  end

  def create
    item = Item.create(item_params)
    if item.id != nil
      render json: ItemSerializer.new(item)
    else
      render json: ErrorSerializer.error("Missing attributes")
    end
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    Item.delete(params[:id])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
