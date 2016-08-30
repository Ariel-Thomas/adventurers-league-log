class DmLogEntry < LogEntry
  attr_accessor :character_id

  def is_dm_log_entry?
    true
  end
end
