class AddNameToContactGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_groups, :name, :string
  end
end
