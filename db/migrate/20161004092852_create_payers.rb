class CreatePayers < ActiveRecord::Migration[5.0]
  def change
    create_table :payers do |t|
      t.string :name
      t.integer :role
    end
  end
end
