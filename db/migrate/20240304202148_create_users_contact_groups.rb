class CreateUsersContactGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :users_contact_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contact_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
