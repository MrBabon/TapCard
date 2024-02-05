class Event < ApplicationRecord
  belongs_to :organization
  has_many :participations, dependent: :destroy
  has_one_attached :logo

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.city = geo.city
      obj.country = geo.country
    end
  end
  after_validation :geocode, if: :will_save_change_to_address?

  def valid_registration_code?(code)
    registration_code.present? && registration_code == code
  end
end
