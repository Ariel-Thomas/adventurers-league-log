class AddPurchaseLogEntriesParamsToLogEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :log_entries, :tier1_treasure_checkpoints, :integer
    add_column :log_entries, :tier2_treasure_checkpoints, :integer
    add_column :log_entries, :tier3_treasure_checkpoints, :integer
    add_column :log_entries, :tier4_treasure_checkpoints, :integer
  end
end
