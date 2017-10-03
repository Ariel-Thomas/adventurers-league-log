class CampaignLogEntryPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end
  end

  def show?
    if record.character && record.character.publicly_visible?
      true
    elsif record.campaign
      if record.campaign.publicly_visible?
        true
      elsif record.campaign.character_users.include?(user)
        true
      else
        user_is_campaign_user
      end
    end
  end

  def print?
    show?
  end

  def new?
    user_is_campaign_user
  end

  def create?
    user_is_campaign_user
  end

  def edit?
    user_is_campaign_user
  end

  def update?
    user_is_campaign_user
  end

  def destroy?
    user_is_campaign_user
  end

  protected

  def user_is_campaign_user
    if record.campaign
      record.campaign.users.include?(user)
    else
      false
    end
  end
end
