class RenameEntrepriseIdToIdEntreprisesInExhibitors < ActiveRecord::Migration[7.0]
  def change
    rename_column :exhibitors, :entreprise_id, :id_Entreprises
  end
end
