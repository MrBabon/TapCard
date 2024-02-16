class CreateAssociationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :association_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :entreprise, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
