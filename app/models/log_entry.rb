class LogEntry < ActiveRecord::Base
  has_many :log_assignments
  has_many :characters, through: :log_assignments
  def character
    characters.first
  end

  def character= char
    characters = [char]
  end

  belongs_to :user
  has_many   :magic_items, dependent: :destroy
  accepts_nested_attributes_for :magic_items, reject_if: proc { |attributes| attributes[:name].blank? }, allow_destroy: true

  self.inheritance_column = :type
  def self.types
    %w(CharacterLogEntry DmLogEntry)
  end

  def user
    temp = super
    return character.user if character
    temp if temp
  end

  enum log_format: [:old, :season8, :season9], _prefix: true

  ransack_alias :xp, :xp_gained
  ransack_alias :gp, :gp_gained
  ransack_alias :downtime, :downtime_gained
  ransack_alias :renown, :renown_gained
  ransack_alias :missions, :num_secret_missions

  def is_character_log_entry?
    false
  end

  def is_dm_log_entry?
    false
  end

  def is_trade_log_entry?
    false
  end

  def is_purchase_log_entry?
    false
  end

  def is_campaign_log_entry?
    false
  end

  class << self
    def earned_treasure_checkpoints(tier:)
      where(treasure_tier: tier).sum(:treasure_checkpoints)
    end

    TREASURE_TIERS = [:tier1_treasure_checkpoints, :tier2_treasure_checkpoints, :tier3_treasure_checkpoints, :tier4_treasure_checkpoints]
    def spent_treasure_checkpoints(tier:)
      sum(TREASURE_TIERS[tier - 1])
    end
  end

  def num_magic_items_gained
    magic_items.where(not_included_in_count: false).count
  end

  def magic_items_campaign
    magic_items.pluck(:name).join(', ')
  end

  def magic_items_list(char, opts = {})
    if opts[:show_purchased]
      list = magic_items.where(character: char).map{|item| item.name + (item.purchased || item.purchase_log_entry_id ? "*" : "")}.join(', ')
    else
      list = magic_items.where(character: char).pluck(:name).join(', ')
    end

    if list == ''
      return ''
    else
      return list
    end
  end

end
