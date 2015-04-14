class AddNotesToLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :notes, :string,  default: "", null: false
  end
end
