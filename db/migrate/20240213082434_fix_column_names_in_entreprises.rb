class FixColumnNamesInEntreprises < ActiveRecord::Migration[7.0]
  def change
    rename_column :entreprises, :linkdin, :linkedin
    rename_column :entreprises, :twiter_x, :twitter
  end
end
