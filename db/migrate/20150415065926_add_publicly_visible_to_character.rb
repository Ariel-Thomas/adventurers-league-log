class AddPubliclyVisibleToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :publicly_visible, :boolean,  default: false, null: false
  end
end
