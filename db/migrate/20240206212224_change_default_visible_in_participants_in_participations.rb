class ChangeDefaultVisibleInParticipantsInParticipations < ActiveRecord::Migration[7.0]
  def change
    change_column_default :participations, :visible_in_participants, false
  end
end
