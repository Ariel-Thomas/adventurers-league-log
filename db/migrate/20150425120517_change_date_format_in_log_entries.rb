class ChangeDateFormatInLogEntries < ActiveRecord::Migration[5.2]
  def up
    change_column :log_entries, :date_played, :datetime
  end

  def down
    change_column :log_entries, :date_played, :date
  end
end
