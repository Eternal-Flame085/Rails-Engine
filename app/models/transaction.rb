class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoices
end
