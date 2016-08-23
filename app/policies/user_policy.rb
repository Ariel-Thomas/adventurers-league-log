class UserPolicy < ApplicationPolicy
  def index?
    user == record
  end

  def edit?
    user == record
  end

  def update?
    user == record
  end

  def publicly_visible_user?
    if record.publicly_visible?
      true
    else
      record == user
    end
  end
end
