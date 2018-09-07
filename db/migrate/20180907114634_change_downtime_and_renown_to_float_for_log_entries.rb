class ChangeDowntimeAndRenownToFloatForLogEntries < ActiveRecord::Migration[5.2]
  def change
    change_column :log_entries, :downtime_gained, :decimal, precision: 8, scale: 1
    change_column :log_entries, :renown_gained, :decimal, precision: 6, scale: 1
  end
end
