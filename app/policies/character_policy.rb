class CharacterPolicy < ApplicationPolicy
  def show?
    publicly_visible? || user_is_current_user || user_is_characters_dm
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

  def user_is_characters_dm
    Campaign.joins(dm_campaign_assignments: :user, campaign_participations: :character)
      .where(dm_campaign_assignments: {user: user}, campaign_participations: {character: record}).exists?
  end
end
