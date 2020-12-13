class Item < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name, :description, :unit_price
  has_many :invoices
  has_many :invoice_items
end
