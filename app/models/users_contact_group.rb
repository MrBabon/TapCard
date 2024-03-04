class UsersContactGroup < ApplicationRecord
  belongs_to :user
  belongs_to :contact_group
end
