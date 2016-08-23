class CharacterLogEntry < LogEntry
  belongs_to :player_dm

  def user
    character.user
  end
end
