class RemovePhoneFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :phone, :string
  end
end
