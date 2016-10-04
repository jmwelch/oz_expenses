class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :name
      t.float :amount
      t.date :date_of_payment
      t.references :payer
      t.string :payment_type

      t.timestamps
    end
  end
end
