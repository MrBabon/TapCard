class AddParrainageCodeToEntreprises < ActiveRecord::Migration[7.0]
  def change
    add_column :entreprises, :parrainage_code, :string
  end
end
