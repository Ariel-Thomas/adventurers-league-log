class AddPubliclyVisibleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :publicly_visible, :boolean
  end
end
