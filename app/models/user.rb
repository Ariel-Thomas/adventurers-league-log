class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :characters
  has_many :campaign_participations, through: :characters
  has_many :character_campaigns, through: :characters, source: :campaigns
  has_many :player_dms
  has_many :locations

  has_many :dm_log_entries

  has_many :dm_campaign_assignments
  has_many :campaigns, through: :dm_campaign_assignments

  enum character_style: [:old, :season8, :all, :season9], _prefix: true
  enum character_log_entry_style: [:old, :season8, :season9], _prefix: true
  enum magic_item_style: [:old, :season8, :season9], _prefix: true
  enum dm_style: [:old, :season8, :all, :season9], _prefix: true
  enum dm_log_entry_style: [:old, :season8, :season9], _prefix: true


  enum round_checkpoints_override: [:no_override, :up, :down], _prefix: true
  enum automagic_gold_toggle_override: [:no_override, :yes, :no], _prefix: true
  enum automagic_downtime_toggle_override: [:no_override, :yes, :no], _prefix: true

end
