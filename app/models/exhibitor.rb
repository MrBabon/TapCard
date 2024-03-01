class Exhibitor < ApplicationRecord
  belongs_to :entreprise, foreign_key: "id_Entreprises"
  belongs_to :event
  has_many :representatives, dependent: :destroy

end
