class AddConversionSpeedToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :conversion_speed, :integer, default: 0
  end
end
