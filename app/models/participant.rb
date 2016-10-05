class Participant < ApplicationRecord
  belongs_to :payer, inverse_of: :participants
  belongs_to :payment, inverse_of: :participants

  delegate :email, to: :payer
  delegate :payer_name, to: :payment, prefix: true
  delegate :name, to: :payer
end
