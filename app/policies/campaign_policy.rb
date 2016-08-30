class CampaignPolicy < ApplicationPolicy
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
      user_is_current_user
    end
  end

  def new?
    user_is_current_user
  end

  def create?
    user_is_current_user
  end

  def edit?
    user_is_current_user
  end

  def update?
    user_is_current_user
  end

  def destroy?
    user_is_current_user
  end
end
