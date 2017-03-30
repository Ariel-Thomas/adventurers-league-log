class CampaignParticipationPolicy < ApplicationPolicy
  def create?
    user_is_current_user && record.campaign && record.campaign.users_can_join?
  end

  def destroy?
    user_is_current_user
  end
end
