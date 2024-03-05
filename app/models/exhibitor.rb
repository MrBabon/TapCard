class Exhibitor < ApplicationRecord
  belongs_to :entreprise
  belongs_to :event
  has_many :representatives, dependent: :destroy

end
