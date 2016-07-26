class CreateLifestyles < ActiveRecord::Migration
  def change
    create_table :lifestyles do |t|
      t.string :name
    end
  end
end
