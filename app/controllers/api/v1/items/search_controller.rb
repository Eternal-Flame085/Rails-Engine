class Api::V1::Items::SearchController < ApplicationController
  def find_item
    render json: ItemSerializer.new(SearchFacade.find_item(params))
  end

  def find_all
    render json: ItemSerializer.new(SearchFacade.find_all_items(params))
  end
end
