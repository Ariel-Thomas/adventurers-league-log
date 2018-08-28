class AddNotIncludedInCountToMagicItems < ActiveRecord::Migration[5.2]
  def change
    add_column :magic_items, :not_included_in_count, :boolean, default: false, null: false
  end
end
