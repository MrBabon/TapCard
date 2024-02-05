class Event < ApplicationRecord
  belongs_to :organization
  has_many :participations, dependent: :destroy
  has_one_attached :logo
  validates :registration_code, presence: true

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
    event_code = registration_code
    errors.add(:registration_code, 'Code de participation incorrect') unless code == event_code
    errors.empty? 
  end
end
