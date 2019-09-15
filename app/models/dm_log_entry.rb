# :nodoc:
class DmLogEntry < LogEntry
  attr_accessor :character_id

  def character_id
    character.id if character
  end

  ransack_alias :character_id, :log_assignments_character_id
  ransack_alias :hours, :session_length_hours

  def is_dm_log_entry?
    true
  end

  enum dm_reward_choice: [:none, :advancement, :magic_item, :campaign_rewards], _prefix: true
end
