class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  def self.fetch_items(id)
    Item.where(merchant_id: id)
  end
end
