class DmCampaignAssignment < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :campaign, required: true

  validates :campaign, uniqueness: { scope: :user,
    message: "The same user may not join the same campaign twice" }

  attr_accessor :token
end
