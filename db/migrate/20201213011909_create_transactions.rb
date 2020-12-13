class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    unless ActiveRecord::Base.connection.table_exists?('transactions')
      create_table :transactions do |t|
        t.references :invoice, foreign_key: true
        t.string :credit_card_number
        t.string :credit_card_date
        t.string :result

        t.timestamps
      end
    end
  end
end
