class Payment < ApplicationRecord
  belongs_to :payer, inverse_of: :payments

  delegate :name, to: :payer, prefix: true
end
