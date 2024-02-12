class Entreprise < ApplicationRecord
    has_many :entrepreneurs, dependent: :destroy
    has_many :employees, dependent: :destroy
    has_many :exhibitors, dependent: :destroy
    has_many :users, through: :entrepreneurs
    has_many :users, through: :employees
    has_one_attached :logo

end
