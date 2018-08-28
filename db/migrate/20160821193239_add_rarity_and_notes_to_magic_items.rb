class AddRarityAndNotesToMagicItems < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_items, :rarity, :integer, null: false, default: 0
    add_column :magic_items, :notes, :string, null: false, default: ''
  end
end
