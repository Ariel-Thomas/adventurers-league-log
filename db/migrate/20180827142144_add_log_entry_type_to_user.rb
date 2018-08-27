class AddLogEntryTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :character_style, :integer, default: 1
    add_column :users, :character_log_entry_style, :integer, default: 1
    add_column :users, :magic_item_style, :integer, default: 1

    add_column :users, :dm_style, :integer, default: 1
    add_column :users, :dm_log_entry_style, :integer, default: 1
  end
end
