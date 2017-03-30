class Character < ActiveRecord::Base
  belongs_to :user

  belongs_to :faction
  belongs_to :lifestyle

  has_many   :log_assignments
  has_many   :log_entries, through: :log_assignments
  has_many   :character_log_entries, through: :log_assignments, source: :log_entry, class_name: CharacterLogEntry
  has_many   :trade_log_entries, through: :log_assignments, source: :log_entry, class_name: TradeLogEntry
  has_many   :dm_log_entries, through: :log_assignments, source: :log_entry, class_name: DmLogEntry
  has_many   :campaign_log_entries, through: :log_assignments, source: :log_entry, class_name: CampaignLogEntry

  has_many   :magic_items

  has_many :campaign_participations, dependent: :destroy
  has_many :campaigns, through: :campaign_participations

  validates :name, presence: true

  XP_BY_LEVEL =
    [0, 300, 900, 2700, 6500, 14_000, 23_000, 34_000, 48_000, 64_000, 85_000, 100_000, 120_000, 140_000, 165_000, 195_000, 225_000, 265_000, 305_000, 355_000].freeze

  def faction_image
    faction.flag_url if faction
  end

  def faction_rank
    return 'None' unless faction
    args = { renown: total_renown,
             secret_missions: total_secret_missions,
             level: current_level }
    faction.rank args
  end

  def faction_name
    if faction_override
      faction_override
    elsif faction
      faction.name
    else
      'None'
    end
  end

  def lifestyle_name
    if lifestyle_override
      lifestyle_override
    elsif lifestyle
      lifestyle.name
    else
      'None'
    end
  end

  def total_xp
    log_entries.pluck(:xp_gained).compact.inject(:+) || 0
  end

  def current_level
    current_xp = total_xp

    XP_BY_LEVEL.each_with_index do |xp_amount, index|
      return index if current_xp < xp_amount
    end

    20
  end

  def xp_to_next_level
    [xp_for_next_level - total_xp, 0].max
  end

  def xp_for_next_level
    XP_BY_LEVEL[current_level] || 0
  end

  def total_gp
    log_entries.pluck(:gp_gained).compact.inject(:+) || 0
  end

  def total_renown
    log_entries.pluck(:renown_gained).compact.inject(:+) || 0
  end

  def total_downtime
    log_entries.pluck(:downtime_gained).compact.inject(:+) || 0
  end

  def total_secret_missions
    log_entries.pluck(:num_secret_missions).compact.inject(:+) || 0
  end

  def total_magic_items
    magic_items.where(trade_log_entry_id: nil).count
  end

  def magic_items_list
    list = magic_items.where(trade_log_entry_id: nil).pluck(:name).join(', ')

    if list == ''
      return 'None'
    else
      return list
    end
  end
end
