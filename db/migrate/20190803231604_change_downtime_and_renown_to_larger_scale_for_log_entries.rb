class ChangeDowntimeAndRenownToLargerScaleForLogEntries < ActiveRecord::Migration[5.2]
  def change
    change_column :log_entries, :downtime_gained, :decimal, precision: 10, scale: 4
    change_column :log_entries, :renown_gained, :decimal, precision: 10, scale: 4
  end
end
