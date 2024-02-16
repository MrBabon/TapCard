class AssociationRequest < ApplicationRecord
  belongs_to :user
  belongs_to :entreprise

  validates :user_id, uniqueness: { scope: :entreprise_id, message: "Vous avez déjà une demande en cours avec cette entreprise." }
end
