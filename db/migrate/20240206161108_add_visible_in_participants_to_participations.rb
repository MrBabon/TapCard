class AddVisibleInParticipantsToParticipations < ActiveRecord::Migration[7.0]
  def change
    add_column :participations, :visible_in_participants, :boolean
  end
end
