class AddTypeAndUserIdToLogEntry < ActiveRecord::Migration
  def change
    add_column :log_entries, :type, :string
    add_column :log_entries, :user_id, :integer

    LogEntry.find_each do |log_entry|
      log_entry.type = "CharacterLogEntry"
      log_entry.save!
    end
  end
end
