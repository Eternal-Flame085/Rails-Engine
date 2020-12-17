class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :transactions

  validates_presence_of :customer_id,
                        :merchant_id

  scope :shipped, -> { where(status: "shipped")}
  scope :between, -> (start_date, end_date) { where(created_at: (start_date)..("#{end_date} 23:59:59"))}

end
