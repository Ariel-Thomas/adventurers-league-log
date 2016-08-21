class RemoveMagicItemFromLogEntries < ActiveRecord::Migration
  def up
    LogEntry.where.not(desc_magic_items_gained: nil, desc_magic_items_gained: "").each do |log_entry|
      MagicItem.create!(name: log_entry.desc_magic_items_gained, log_entry: log_entry)
    end

    remove_column :log_entries, :num_magic_items_gained, :integer
    remove_column :log_entries, :desc_magic_items_gained, :string
  end

  def down
    add_column :log_entries, :num_magic_items_gained, :integer
    add_column :log_entries, :desc_magic_items_gained, :string
  end
end
