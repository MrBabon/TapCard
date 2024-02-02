class Event < ApplicationRecord
  belongs_to :organization
  has_many :participations, dependent: :destroy
  has_one_attached :logo

  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  def valid_registration_code?(code)
    registration_code.present? && registration_code == code
  end
end
