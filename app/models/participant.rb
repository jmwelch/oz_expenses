class Participant < ApplicationRecord
  belongs_to :payer, inverse_of: :participants
  belongs_to :payment, inverse_of: :participants

  delegate :email, to: :payer
  delegate :name, to: :payer, prefix: true
end
