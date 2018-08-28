class CreateLogEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :log_entries do |t|
      t.integer :character_id

      t.date    :date_played
      t.string  :adventure_title
      t.integer :session_num
      t.integer :xp_gained
      t.integer :gp_gained
      t.integer :num_magic_items_gained
      t.string  :desc_magic_items_gained
      t.integer :renown_gained
      t.integer :downtime_gained

      t.string  :location_played
      t.string  :dm_name
      t.string  :dm_dci_number
    end
  end
end
