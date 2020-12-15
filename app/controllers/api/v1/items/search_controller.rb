class Api::V1::Items::SearchController < ApplicationController
  def find_item
    attribute = params.keys.first
    render json: ItemSerializer.new(Item.where("#{attribute} ILIKE ?", "%#{params[attribute]}%").first)
  end

  def find_all
    attribute = params.keys.first
    if attribute == 'unit_price'
      render json: ItemSerializer.new(Item.where(unit_price: params[attribute]))
    else
      render json: ItemSerializer.new(Item.where("#{attribute} ILIKE ?", "%#{params[attribute]}%"))
    end
  end
end
