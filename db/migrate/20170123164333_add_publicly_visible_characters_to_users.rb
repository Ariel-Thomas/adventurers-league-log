class AddPubliclyVisibleCharactersToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :publicly_visible, :publicly_visible_dm_logs
    add_column :users, :publicly_visible_characters, :boolean
  end
end
