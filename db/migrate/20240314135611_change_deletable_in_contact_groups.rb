class ChangeDeletableInContactGroups < ActiveRecord::Migration[7.0]
  def change
    change_column_default :contact_groups, :deletable, from: nil, to: true
  end
end
