class Entreprise < ApplicationRecord
    has_many :entrepreneurs, dependent: :destroy
    has_many :employees, dependent: :destroy
    has_many :exhibitors, dependent: :destroy
    has_many :users, through: :entrepreneurs
    has_many :users, through: :employees
    has_one_attached :logo

    before_create :generate_parrainage_code

    private

    def generate_parrainage_code
      self.parrainage_code = generate_unique_code
    end
  
    def generate_unique_code
      loop do
        code = SecureRandom.hex(4).upcase # Vous pouvez ajuster la longueur du code selon vos besoins
        break code unless Entreprise.exists?(parrainage_code: code)
      end
    end
    
end
