class AddEmployeeIdAndEntrepreneurIdToRepresentatives < ActiveRecord::Migration[7.0]
  def change
    add_column :representatives, :employee_id, :bigint
    add_column :representatives, :entrepreneur_id, :bigint
  end
end
