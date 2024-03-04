class CreateContactEntreprises < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_entreprises do |t|
      t.references :user, null: false, foreign_key: true
      t.references :entreprise, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :category
      t.text :message

      t.timestamps
    end
  end
end
