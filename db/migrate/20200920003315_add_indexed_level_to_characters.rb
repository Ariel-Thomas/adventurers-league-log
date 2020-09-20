class AddIndexedLevelToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :indexed_level, :integer, default: 1

    Character.in_batches.each_record {|c| c.update({})}
  end
end
