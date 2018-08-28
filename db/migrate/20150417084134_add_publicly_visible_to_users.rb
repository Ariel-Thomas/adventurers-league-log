class AddPubliclyVisibleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :publicly_visible, :boolean
  end
end
