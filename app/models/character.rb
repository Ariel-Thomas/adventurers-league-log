class Character < ActiveRecord::Base
  include XPConcern
  include AdvancementCheckpointsConcern
  include MilestoneConcern
  include GoldConcern
  include DowntimeConcern
  include FactionConcern
  include LifestyleConcern

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

  enum conversion_speed: [:normal, :slow], _prefix: true
  enum conversion_type: [:round_up, :round_down], _prefix: true
  enum round_checkpoints: [:up, :down], _prefix: true
  enum automagic_gold_toggle: [:yes, :no], _prefix: true
  enum automagic_downtime_toggle: [:yes, :no], _prefix: true

  def current_level
    milestone_level > 20 ? 20 : milestone_level
  end

  def total_renown
    log_entries.sum(:renown_gained)
  end

  def total_secret_missions
    log_entries.sum(:num_secret_missions)
  end

  def total_treasure_checkpoints
    log_entries.sum(:treasure_checkpoints)
  end

  def total_magic_items
    magic_items.purchased.not_traded.where(not_included_in_count: false).count
  end

  MAX_MAGIC_ITEMS_ARRAY = [1,3,6,10]
  def magic_item_limit
    case current_level
    when 1..4
      return MAX_MAGIC_ITEMS_ARRAY[0]
    when 5..10
      return MAX_MAGIC_ITEMS_ARRAY[1]
    when 11..16
      return MAX_MAGIC_ITEMS_ARRAY[2]
    else
      return MAX_MAGIC_ITEMS_ARRAY[3]
    end
  end

end
