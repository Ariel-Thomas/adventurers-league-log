# :nodoc:
class Campaign < ActiveRecord::Base
  belongs_to :user, required: true

  has_many :campaign_log_entries
  has_many :campaign_participations, dependent: :destroy
  has_many :characters, through: :campaign_participations
  has_many :character_users, through: :campaign_participations, source: :user

  before_validation :reset_token, on: :create

  def reset_token
    self.token = SecureRandom.base64(18)
  end

  def reset_token!
    reset_token
    save!
  end
end
