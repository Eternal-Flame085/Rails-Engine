class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  def self.fetch_items(id)
    Item.where(merchant_id: id)
  end

  def self.find_all_merchant_search(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%")
  end

  def self.find_merchant(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%").first
  end
end
