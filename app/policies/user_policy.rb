class UserPolicy < ApplicationPolicy
  def index?
    user == record
  end

  def join?
    user == record
  end

  def edit?
    user == record
  end

  def update?
    user == record
  end

  def publicly_visible_dm_logs?
    if record.publicly_visible_dm_logs?
      true
    else
      record == user
    end
  end
end
