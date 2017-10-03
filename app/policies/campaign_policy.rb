
class CampaignPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.joins(:dm_campaign_assignments).where(dm_campaign_assignments: { user: user })
    end
  end

  def index?
    true
  end

  def join?
    user_is_current_user
  end

  def show?
    if record.publicly_visible?
      true
    elsif record.character_users.include?(user)
      true
    else
      user_is_campaign_user
    end
  end

  def new?
    user_is_current_user
  end

  def create?
    user_is_current_user
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
    record.users.include?(user)
  end
end
