class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    unless ActiveRecord::Base.connection.table_exists?('merchants')
      create_table :merchants do |t|
        t.string :name

        t.timestamps
      end
    end
  end
end
