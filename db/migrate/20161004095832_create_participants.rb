class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :payer
      t.references :payment
      t.float :amount, null: false, default: 0
    end
  end
end
