class AddTierToMagicItems < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_items, :tier, :integer

    add_column :magic_items, :purchased, :boolean, default: false, null: false
    MagicItem.update_all(purchased: true)
  end
end
