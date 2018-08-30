class Character < ActiveRecord::Base
  include XPConcern
  include AdvancementCheckpointsConcern
  include GoldConcern
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

  def current_level
    checkpoint_level
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

  def total_treasure_checkpoints
    log_entries.sum(:treasure_checkpoints)
  end

  def total_magic_items
    magic_items.where(purchased: true).where(not_included_in_count: false).count
  end

  def magic_items_list
    list = magic_items.purchased.pluck(:name).join(', ')

    if list == ''
      return 'None'
    else
      return list
    end
  end
end
