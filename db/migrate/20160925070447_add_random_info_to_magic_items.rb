class AddRandomInfoToMagicItems < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_items, :table, :string
    add_column :magic_items, :table_result, :string
    add_column :magic_items, :location_found, :string
  end
end
