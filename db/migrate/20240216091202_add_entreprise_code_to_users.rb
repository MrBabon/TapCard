class AddEntrepriseCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :entreprise_code, :string
  end
end
