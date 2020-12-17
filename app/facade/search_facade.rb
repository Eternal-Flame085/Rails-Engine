class SearchFacade
  def self.find_item(params)
    attribute = params.keys.first
    if attribute == 'unit_price'
      Item.find_item_with_unit_price(params[attribute])
    else
      Item.find_item(attribute, params[attribute])
    end
  end

  def self.find_all_items(params)
    attribute = params.keys.first
    if attribute == 'unit_price'
      Item.find_items_with_unit_price(params[attribute])
    else
      Item.find_all_items_search(attribute, params[attribute])
    end
  end

  def self.find_merchant(params)
    attribute = params.keys.first
    Merchant.find_merchant(attribute, params[attribute])
  end

  def self.find_all_merchants(params)
    attribute = params.keys.first
    Merchant.find_all_merchant_search(attribute, params[attribute])
  end

  def self.most_revenue(params)
    Merchant.find_most_revenue(params[:quantity])
  end

  def self.most_items(params)
    Merchant.find_most_items_sold(params[:quantity])
  end

  def self.revenue_accross_dates(params)
    Merchant.total_revenue_across_dates(params[:start], params[:end])
  end
end
