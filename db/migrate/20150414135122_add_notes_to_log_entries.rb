class AddNotesToLogEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :log_entries, :notes, :string, default: '', null: false
  end
end
