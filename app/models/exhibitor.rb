class Exhibitor < ApplicationRecord
  belongs_to :entreprise
  belongs_to :event
  has_many :representatives, dependent: :destroy
  has_many :enterprises, through: :representatives

end
