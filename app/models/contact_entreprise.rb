class ContactEntreprise < ApplicationRecord
  belongs_to :user
  belongs_to :entreprise
  belongs_to :event

end
