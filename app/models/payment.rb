class Payment < ApplicationRecord
  belongs_to :payer, inverse_of: :payments
  has_many :participants, inverse_of: :payment

  delegate :name, to: :payer, prefix: true
end
