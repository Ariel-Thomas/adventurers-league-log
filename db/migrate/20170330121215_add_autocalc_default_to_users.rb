class AddAutocalcDefaultToUsers < ActiveRecord::Migration
  def change
    add_column :users, :autocalc_default, :boolean, default: true, null: false
  end
end
