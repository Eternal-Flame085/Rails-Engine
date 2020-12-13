class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :credit_card_date,
                        :result
end
