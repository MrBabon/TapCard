class AddRegistrationCodeToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :registration_code, :string
  end
end
