class Payment < ApplicationRecord
  validates :payment_type, inclusion: { in: proc { Payment::PAYMENT_TYPES } }

  belongs_to :payer, inverse_of: :payments
  has_many :participants, inverse_of: :payment, dependent: :destroy

  accepts_nested_attributes_for :participants

  delegate :name, to: :payer, prefix: true
  delegate :email, to: :payer

  PURCHASE = 'purchase'
  SETTLEMENT = 'settlement'
  PAYMENT_TYPES = [
    PURCHASE,
    SETTLEMENT
  ].freeze
end
