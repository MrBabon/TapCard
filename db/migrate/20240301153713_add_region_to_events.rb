class AddRegionToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :region, :string
  end
end
