class CreatePlayerDm < ActiveRecord::Migration[5.2]
  def change
    create_table :player_dms do |t|
      t.string  :name
      t.string  :dci
      t.integer :user_id
    end

    add_column :log_entries, :player_dm_id, :integer

    User.all.each do |user|
      user.characters.all.each do |character|
        character.character_log_entries.all.each do |log_entry|
          next unless log_entry.dm_dci_number && log_entry.dm_dci_number != ''

          player_dm = user.player_dms.find_by(dci: log_entry.dm_dci_number)

          if player_dm
            log_entry.player_dm = player_dm
            log_entry.save!
          else
            player_dm = user.player_dms.create!(
              name: log_entry.dm_name,
              dci:  log_entry.dm_dci_number
            )

            log_entry.player_dm = player_dm
            log_entry.save!
          end
        end
      end
    end
  end
end
