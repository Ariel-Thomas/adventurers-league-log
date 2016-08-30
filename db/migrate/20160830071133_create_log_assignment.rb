class CreateLogAssignment < ActiveRecord::Migration
  def change
    create_table :log_assignments do |t|
      t.integer :character_id
      t.integer :log_entry_id
    end

    Character.all.each do |character|
      LogEntry.where(character_id: character.id).each do |log_entry|
        LogAssignment.create!(character: character, log_entry: log_entry)
      end
    end

    remove_column :log_entries, :character_id, :integer
  end
end
