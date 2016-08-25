class CharacterLogEntry < LogEntry
  belongs_to :player_dm

  def user
    character.user
  end

  def dm_name
    database_entry = super
    return database_entry if database_entry
    return "" unless player_dm
    player_dm.name
  end

  def dm_dci_number
    database_entry = super
    return database_entry if database_entry
    return "" unless player_dm
    player_dm.dci
  end

  def is_character_log_entry?
    true
  end
end
