class AddDmRewardChoiceToLogEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :log_entries, :dm_reward_choice, :integer, default: 0
  end
end
