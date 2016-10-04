class Payer < ApplicationRecord
  has_many :payments, inverse_of: :payer
end
