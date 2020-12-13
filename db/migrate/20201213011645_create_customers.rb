class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    unless ActiveRecord::Base.connection.table_exists?('customers')
      create_table :customers do |t|
        t.string :first_name
        t.string :last_name

        t.timestamps
      end
    end
  end
end
