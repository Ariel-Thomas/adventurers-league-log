class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :characters
  has_many :campaign_participations, through: :characters
  has_many :character_campaigns, through: :characters, source: :campaigns

  has_many :player_dms

  has_many :dm_log_entries
  has_many :campaigns

  def total_xp
    dm_log_entries.pluck(:xp_gained).compact.inject(:+) || 0
  end

  def total_unassigned_xp
    dm_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:xp_gained).compact.inject(:+) || 0
  end

  def total_gp
    dm_log_entries.pluck(:gp_gained).compact.inject(:+) || 0
  end

  def total_unassigned_gp
    dm_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:gp_gained).compact.inject(:+) || 0
  end

  def total_downtime
    dm_log_entries.pluck(:downtime_gained).compact.inject(:+) || 0
  end

  def total_unassigned_downtime
    dm_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:downtime_gained).compact.inject(:+) || 0
  end

  def total_renown
    dm_log_entries.pluck(:renown_gained).compact.inject(:+) || 0
  end

  def total_unassigned_renown
    dm_log_entries.includes(:log_assignments).where(log_assignments: {log_entry_id: nil }).pluck(:renown_gained).compact.inject(:+) || 0
  end

  def total_hours
    dm_log_entries.pluck(:session_length_hours).compact.inject(:+) || 0
  end
end
