class CreateRepresentatives < ActiveRecord::Migration[7.0]
  def change
    create_table :representatives do |t|
      t.references :entreprise, null: false, foreign_key: true
      t.references :exhibitor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
