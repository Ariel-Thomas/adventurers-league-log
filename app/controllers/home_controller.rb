class HomeController < ApplicationController
  def index
    if current_user
      redirect_to(user_characters_path(current_user)) && return
    else
      @show_jumbotron = true
    end
  end

  def stats
    @users_count             = User.count
    @characters_count        = Character.count
    @public_characters_count = Character.where(publicly_visible: true).count
    @log_entries_count       = LogEntry.count

    @factions_count          = Faction.all.map { |faction| [faction.name, faction.characters.count] }

    @seasons                 = Character.distinct.pluck(:season).sort
    @tags                    = Character.distinct.pluck(:tag).sort
  end

  def donate

  end
end
