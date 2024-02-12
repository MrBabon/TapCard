class Exhibitor < ApplicationRecord
  belongs_to :entreprise
  belongs_to :event
end
