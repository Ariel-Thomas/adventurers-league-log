class AddSessionLengthAndPlayerLevelToLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :session_length_hours, :integer
    add_column :log_entries, :player_level, :integer
  end
end
