class CharacterLogEntry < LogEntry
  belongs_to :player_dm

  def user
    return character.user
  end
end