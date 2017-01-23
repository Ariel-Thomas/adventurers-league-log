class UserPolicy < ApplicationPolicy
  def index?
    user_is_current_user?
  end

  def join?
    user_is_current_user?
  end

  def edit?
    user_is_current_user?
  end

  def update?
    user_is_current_user?
  end

  def show_characters?
    user_is_current_user? || record.publicly_visible_characters?
  end

  def user_is_current_user?
    record == user
  end

  def publicly_visible_dm_logs?
    if record.publicly_visible_dm_logs?
      true
    else
      record == user
    end
  end
end
