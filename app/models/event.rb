class Event < ApplicationRecord
  belongs_to :organization
  has_many :participations

  def valid_registration_code?(code)
    registration_code.present? && registration_code == code
  end
end
