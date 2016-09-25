class AddRandomInfoToMagicItems < ActiveRecord::Migration
  def change
    add_column :magic_items, :table, :string
    add_column :magic_items, :table_result, :string
    add_column :magic_items, :location_found, :string
  end
end
