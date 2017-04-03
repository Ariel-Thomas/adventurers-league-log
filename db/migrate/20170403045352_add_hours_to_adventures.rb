class AddHoursToAdventures < ActiveRecord::Migration
  def change
    add_column :adventures, :hours, :integer
  end
end
