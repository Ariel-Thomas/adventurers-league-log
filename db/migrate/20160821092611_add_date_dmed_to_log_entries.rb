class AddDateDmedToLogEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :log_entries, :date_dmed, :datetime
  end
end
