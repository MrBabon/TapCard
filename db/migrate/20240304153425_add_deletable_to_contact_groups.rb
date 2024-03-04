class AddDeletableToContactGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_groups, :deletable, :boolean
  end
end
