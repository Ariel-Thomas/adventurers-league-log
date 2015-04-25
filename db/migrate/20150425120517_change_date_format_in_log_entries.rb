class ChangeDateFormatInLogEntries < ActiveRecord::Migration
  def up
    change_column :log_entries, :date_played, :datetime
  end

  def down
    change_column :log_entries, :date_played, :date
  end
end
