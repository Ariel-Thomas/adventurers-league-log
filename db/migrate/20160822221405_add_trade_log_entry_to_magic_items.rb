class AddTradeLogEntryToMagicItems < ActiveRecord::Migration
  def change
    add_column :magic_items, :trade_log_entry_id, :integer
  end
end
