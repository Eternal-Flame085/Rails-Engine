class SingleItemSerializer
  def self.format_item(item)
    {
      data: {
        id: item.id,
        type: "item",
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id,
        }
      }
    }
  end
end
