class LogEntry < ActiveRecord::Base
  belongs_to :character
  belongs_to :user

  self.inheritance_column = :type
  def self.types
    %w(CharacterLogEntry DmLogEntry)
  end


  def user
    temp = super
    return character.user unless temp
    temp
  end

  def is_dm_log_entry?
    false
  end
end