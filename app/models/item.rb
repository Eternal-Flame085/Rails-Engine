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
    where("#{attribute} ILIKE ?", "%#{value}%").first
  end

  def self.find_item_with_unit_price(value)
    where(unit_price: value).first
  end

  def self.find_items_with_unit_price(value)
    where(unit_price: value)
  end

  def self.find_all_items_search(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%")
  end
end
