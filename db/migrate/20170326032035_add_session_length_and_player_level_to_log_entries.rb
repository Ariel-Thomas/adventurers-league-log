class AddSessionLengthAndPlayerLevelToLogEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :log_entries, :session_length_hours, :integer
    add_column :log_entries, :player_level, :integer
  end
end
