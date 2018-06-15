class AddLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string  :name
      t.integer :user_id
    end
  end
end
