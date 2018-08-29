class AddConversionTypeToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :conversion_type, :integer, default: 0
  end
end
