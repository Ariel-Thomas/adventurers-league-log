class AddLifestyleToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :lifestyle_id, :integer
    add_column :characters, :lifestyle_override, :string
  end
end
