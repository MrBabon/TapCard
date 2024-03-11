class AddPersonalNoteToUsersContactGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :users_contact_groups, :personal_note, :text
  end
end
