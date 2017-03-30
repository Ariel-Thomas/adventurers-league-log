class AddNotIncludedInCountToMagicItems < ActiveRecord::Migration
  def change
    add_column :magic_items, :not_included_in_count, :boolean, default: false, null: false
  end
end
