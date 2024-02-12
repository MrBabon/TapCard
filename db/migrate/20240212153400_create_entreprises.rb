class CreateEntreprises < ActiveRecord::Migration[7.0]
  def change
    create_table :entreprises do |t|
      t.string :name
      t.string :email
      t.string :website
      t.string :linkdin
      t.string :instagram
      t.string :facebook
      t.string :twiter_x
      t.text :description

      t.timestamps
    end
  end
end
