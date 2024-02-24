class AddHeadlineAndIndustryToEntreprise < ActiveRecord::Migration[7.0]
  def change
    add_column :entreprises, :headline, :string
    add_column :entreprises, :industry, :string
  end
end
