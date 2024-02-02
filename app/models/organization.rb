class Organization < ApplicationRecord
    has_many :directors, dependent: :destroy
    has_many :users, through: :directors
    has_many :events, dependent: :destroy
end
