class Entrepreneur < ApplicationRecord
  belongs_to :entreprise
  belongs_to :user

  def create
    if current_user.employees.exists?
      redirect_to some_path, alert: 'Vous êtes déjà enregistré en tant qu’employé.'
    else
      # Logique pour créer un entrepreneur
    end
  end
end
