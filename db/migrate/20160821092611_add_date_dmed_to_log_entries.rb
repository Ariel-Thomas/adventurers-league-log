class AddDateDmedToLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :date_dmed, :datetime
  end
end
