class AddIndices < ActiveRecord::Migration[5.2]
  def change
    LogAssignment.select(:character_id, :log_entry_id).group(:character_id, :log_entry_id).having("count(*) > 1")
      .each{ |x| LogAssignment.find_by(character_id: x.character_id, log_entry_id: x.log_entry_id).delete }

    add_index :log_assignments, [:character_id, :log_entry_id], unique: true
    add_index :log_assignments, [:log_entry_id, :character_id], unique: true
    add_index :magic_items, [:log_entry_id, :character_id]

    add_index :log_entries, :user_id
    add_index :log_entries, :campaign_id
    add_index :characters, :user_id
  end
end
