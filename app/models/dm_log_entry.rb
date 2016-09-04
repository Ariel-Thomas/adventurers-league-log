# :nodoc:
class DmLogEntry < LogEntry
  attr_accessor :character_id

  def dm_log_entry?
    true
  end
end
