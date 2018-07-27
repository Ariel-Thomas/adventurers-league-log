class AddCheckpointsToLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :xp_checkpoints, :integer
    add_column :log_entries, :treasure_checkpoints, :integer

    add_column :log_entries, :old_format, :boolean, default: false, null: false
    LogEntry.update_all(old_format: true)
  end
end
