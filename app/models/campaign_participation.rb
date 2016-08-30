class CampaignParticipation < ActiveRecord::Base
  belongs_to :campaign, required: true
  belongs_to :character, required: true

  has_one :user, through: :character

  validates :campaign, uniqueness: { scope: :character,
    message: "The same character may not join the same campaign twice" }

  attr_accessor :token
end
