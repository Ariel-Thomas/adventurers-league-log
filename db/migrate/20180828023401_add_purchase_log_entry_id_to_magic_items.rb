class AddPurchaseLogEntryIdToMagicItems < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_items, :purchase_log_entry_id, :integer
  end
end
