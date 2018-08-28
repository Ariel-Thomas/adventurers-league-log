class AddHoursToAdventures < ActiveRecord::Migration[5.2]
  def change
    add_column :adventures, :hours, :integer
  end
end
