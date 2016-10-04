class Payment < ApplicationRecord
  belongs_to :payer, inverse_of: :payments
  has_many :participants, inverse_of: :payment, dependent: :destroy

  accepts_nested_attributes_for :participants

  delegate :name, to: :payer, prefix: true
end
