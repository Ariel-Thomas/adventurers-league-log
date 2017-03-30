class DmCampaignAssignmentPolicy < ApplicationPolicy
  def create?
    user_is_current_user && record.campaign && record.campaign.dms_can_join?
  end

  def destroy?
    user_is_current_user
  end
end
