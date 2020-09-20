class AddIndexedLevelToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :indexed_level, :integer, default: 1

    batch_count = Character.count / 100
    Character.find_in_batches(batch_size: 100).with_index do |batch, batch_index|
      puts "Processing #{batch_index} / #{batch_count}"
      batch.each {|c| c.update({})}
    end
  end
end
