# :nodoc:
class DmLogEntry < LogEntry
  attr_accessor :character_id

  def character_id
    character.id if character
  end


  def is_dm_log_entry?
    true
  end
end
