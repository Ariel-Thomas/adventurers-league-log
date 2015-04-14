class AddPortraitUrlToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :portrait_url, :string
  end
end
