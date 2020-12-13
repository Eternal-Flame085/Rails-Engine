class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price
end
