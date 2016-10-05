class AddEmailToPayers < ActiveRecord::Migration[5.0]
  def change
    add_column :payers, :email, :string
  end
end
