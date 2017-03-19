class PlayerDmPolicy < ApplicationPolicy
  def show?
    user_is_current_user
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
