class AddAutocalcDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :autocalc_default, :boolean, default: true, null: false
  end
end
