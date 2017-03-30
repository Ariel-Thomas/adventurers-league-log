# :nodoc:
class Campaign < ActiveRecord::Base
  has_many :dm_campaign_assignments, dependent: :destroy
  validates :dm_campaign_assignments, presence: true
  has_many :users, through: :dm_campaign_assignments

  def user
    users.first
  end

  def user= u
    users = [u]
  end


  has_many :campaign_log_entries
  has_many :campaign_participations, dependent: :destroy
  has_many :characters, through: :campaign_participations
  has_many :character_users, through: :campaign_participations, source: :user

  before_validation :reset_tokens, on: :create

  def reset_tokens
    self.token = SecureRandom.base64(18)
    self.dm_token = SecureRandom.base64(18)
  end

  def reset_tokens!
    reset_tokens
    save!
  end
end
