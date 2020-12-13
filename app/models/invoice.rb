class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :transactions

  validates_presence_of :customer_id,
                        :merchant_id
end
