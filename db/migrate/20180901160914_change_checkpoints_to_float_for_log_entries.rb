class ChangeCheckpointsToFloatForLogEntries < ActiveRecord::Migration[5.2]
  def change
    change_column :log_entries, :advancement_checkpoints, :decimal, precision: 8, scale: 1
    change_column :log_entries, :treasure_checkpoints, :decimal, precision: 6, scale: 1

    change_column :log_entries, :tier1_treasure_checkpoints, :decimal, precision: 6, scale: 1
    change_column :log_entries, :tier2_treasure_checkpoints, :decimal, precision: 6, scale: 1
    change_column :log_entries, :tier3_treasure_checkpoints, :decimal, precision: 6, scale: 1
    change_column :log_entries, :tier4_treasure_checkpoints, :decimal, precision: 6, scale: 1
  end
end
