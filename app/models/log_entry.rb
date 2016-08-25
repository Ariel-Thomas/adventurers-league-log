class LogEntry < ActiveRecord::Base
  belongs_to :character
  belongs_to :user
  has_many   :magic_items
  accepts_nested_attributes_for :magic_items, reject_if: proc { |attributes| attributes[:name].blank? }, allow_destroy: true

  self.inheritance_column = :type
  def self.types
    %w(CharacterLogEntry DmLogEntry)
  end

  def user
    temp = super
    return character.user unless temp
    temp
  end

  def is_character_log_entry?
    false
  end

  def is_dm_log_entry?
    false
  end

  def is_trade_log_entry?
    false
  end

  def num_magic_items_gained
    magic_items.count
  end

  def magic_items_list
    list = magic_items.pluck(:name).join(', ')

    if list == ''
      return ''
    else
      return list
    end
  end
end
