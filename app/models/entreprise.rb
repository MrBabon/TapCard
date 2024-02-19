class Entreprise < ApplicationRecord
  
    # ENTREPRENEUR
    has_many :entrepreneurs, dependent: :destroy
    has_many :owners, through: :entrepreneurs, source: :user
    # EMPLOYEE
    has_many :employee_relationships, class_name: 'Employee', dependent: :destroy
    has_many :employees, through: :employee_relationships, source: :user
    # ASSOCIATION REQUEST
    has_many :association_requests, dependent: :destroy
    # EXHIBITOR
    has_many :exhibitors, dependent: :destroy
    has_one_attached :logo

    before_create :generate_parrainage_code

    private

    def generate_parrainage_code
      self.parrainage_code = generate_unique_code
    end
  
    def generate_unique_code
      loop do
        code = SecureRandom.hex(6).upcase # Vous pouvez ajuster la longueur du code selon vos besoins
        break code unless Entreprise.exists?(parrainage_code: code)
      end
    end
    
end
