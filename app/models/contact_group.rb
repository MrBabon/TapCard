class ContactGroup < ApplicationRecord
  belongs_to :repertoire
  has_many :users_contact_groups
  has_many :users, through: :users_contact_groups
end
