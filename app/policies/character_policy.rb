class CharacterPolicy < ApplicationPolicy
  def show?
    if publicly_visible?
      true
    else
      user_is_current_user
    end
  end

  def print?
    show?
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

  def publicly_visible?
    if record.publicly_visible? || record.user.publicly_visible_characters?
      true
    else
      false
    end
  end
end
