class AddPlayerDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :dci_num, :string
  end
end
