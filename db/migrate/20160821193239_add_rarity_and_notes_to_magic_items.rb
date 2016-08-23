class AddRarityAndNotesToMagicItems < ActiveRecord::Migration
  def change
    add_column :magic_items, :rarity, :integer, null: false, default: 0
    add_column :magic_items, :notes, :string, null: false, default: ''
  end
end
