class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  def self.fetch_merchant(item_id)
    self.find(item_id).merchant
  end

  def self.find_item(attribute, value)
    if attribute == 'unit_price'  || attribute == 'id'
      where(attribute.to_sym => value).first
    elsif  attribute == 'created_at'  || attribute == 'updated_at'
      where(attribute.to_sym => ("#{value} 00:00:00")..("#{value} 23:59:59")).first
    else
      where("#{attribute} ILIKE ?", "%#{value}%").first
    end
  end

  def self.find_all_items_search(attribute, value)
    if attribute == 'unit_price'  || attribute == 'id'
      where(unit_price: value)
    elsif  attribute == 'created_at'  || attribute == 'updated_at'
      where(attribute.to_sym => ("#{value} 00:00:00")..("#{value} 23:59:59"))
    else
      where("#{attribute} ILIKE ?", "%#{value}%")
    end
  end
end
