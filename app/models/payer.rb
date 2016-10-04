class Payer < ApplicationRecord
  validates :role, inclusion: { in: proc { Payer::ROLES } }

  has_many :payments, inverse_of: :payer, dependent: :destroy
  has_many :participants, inverse_of: :payer, dependent: :destroy

  ROLES = {
    1 => 'admin',
    2 => 'viewer'
  }.freeze

  def get_role
    ROLES.fetch(role, nil)
  end
end
