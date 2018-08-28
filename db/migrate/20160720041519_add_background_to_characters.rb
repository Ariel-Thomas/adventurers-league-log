class AddBackgroundToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :background, :string
  end
end
