class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :class_and_levels
      t.string :faction

      t.integer :user_id
    end
  end
end
