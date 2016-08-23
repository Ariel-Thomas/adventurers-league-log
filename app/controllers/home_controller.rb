class HomeController < ApplicationController
  def index
    if current_user
      redirect_to(user_characters_path(current_user)) && return
    else
      @show_jumbotron = true
    end
  end

  def adventures
    @adventures = AdventureFormInput.all
  end

  def stats
    @users_count             = User.count
    @public_users_count      = User.where(publicly_visible: true).count
    @characters_count        = Character.count
    @public_characters_count = Character.where(publicly_visible: true).count
    @log_entries_count       = LogEntry.count

    @factions_count          = Faction.all.map { |faction| [faction.name, faction.characters.count] }
  end
end
