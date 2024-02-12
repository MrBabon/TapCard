class Employee < ApplicationRecord
  belongs_to :entreprise
  belongs_to :user
end
