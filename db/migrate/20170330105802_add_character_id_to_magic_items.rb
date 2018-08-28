class AddCharacterIdToMagicItems < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_items, :character_id, :integer

    MagicItem.all.each do |mi|
      mi.destroy and next unless mi.log_entry && mi.log_entry.character
      mi.update!(character_id: mi.log_entry.character.id)
    end
  end
end
