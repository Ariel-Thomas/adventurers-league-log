class Character < ActiveRecord::Base
  include CharacterXP
  include CharacterCheckpoints

  belongs_to :user

  belongs_to :faction
  belongs_to :lifestyle

  has_many   :log_assignments
  has_many   :log_entries, through: :log_assignments
  has_many   :character_log_entries, through: :log_assignments, source: :log_entry, class_name: 'CharacterLogEntry'
  has_many   :trade_log_entries, through: :log_assignments, source: :log_entry, class_name: 'TradeLogEntry'
  has_many   :purchase_log_entries, through: :log_assignments, source: :log_entry, class_name: 'PurchaseLogEntry'
  has_many   :dm_log_entries, through: :log_assignments, source: :log_entry, class_name: 'DmLogEntry'
  has_many   :campaign_log_entries, through: :log_assignments, source: :log_entry, class_name: 'CampaignLogEntry'

  has_many   :magic_items

  has_many :campaign_participations, dependent: :destroy
  has_many :campaigns, through: :campaign_participations

  validates :name, presence: true

  def faction_image
    faction.flag_url if faction
  end

  def faction_rank
    return 'None' unless faction
    args = { renown: total_renown,
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

  def total_gp
    log_entries.sum(:gp_gained)
  end

  def total_renown
    log_entries.sum(:renown_gained)
  end

  def total_downtime
    log_entries.sum(:downtime_gained)
  end

  def total_secret_missions
    log_entries.sum(:num_secret_missions)
  end

  TREASURE_TIERS = [:tier1_treasure_checkpoints, :tier2_treasure_checkpoints, :tier3_treasure_checkpoints, :tier4_treasure_checkpoints]
  def treasure_checkpoints(tier:)
    log_entries.where(treasure_tier: tier).sum(:treasure_checkpoints) - log_entries.sum(TREASURE_TIERS[tier - 1])
  end

  def total_treasure_checkpoints
    log_entries.sum(:treasure_checkpoints)
  end

  def total_magic_items
    magic_items.where(purchased: true).where(not_included_in_count: false).count
  end

  def magic_items_list
    list = magic_items.where(purchased: true).pluck(:name).join(', ')

    if list == ''
      return 'None'
    else
      return list
    end
  end
end
