class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :address
      t.string :phone
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :link
      t.datetime :start_time
      t.datetime :end_time
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
