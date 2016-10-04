class Participant < ApplicationRecord
  belongs_to :payer, inverse_of: :participants
  belongs_to :payment, inverse_of: :participants
end
