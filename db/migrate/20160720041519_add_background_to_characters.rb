class AddBackgroundToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :background, :string
  end
end
