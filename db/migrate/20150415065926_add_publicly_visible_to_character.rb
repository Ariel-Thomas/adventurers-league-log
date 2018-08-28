class AddPubliclyVisibleToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :publicly_visible, :boolean, default: false, null: false
  end
end
