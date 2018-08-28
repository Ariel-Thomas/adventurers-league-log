class AddPortraitUrlToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :portrait_url, :string
  end
end
