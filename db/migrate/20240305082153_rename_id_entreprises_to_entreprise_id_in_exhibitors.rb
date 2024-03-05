class RenameIdEntreprisesToEntrepriseIdInExhibitors < ActiveRecord::Migration[7.0]
  def change
    rename_column :exhibitors, :id_Entreprises, :entreprise_id
  end
end
