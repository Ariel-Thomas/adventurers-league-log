module Character::FactionConcern
  def faction_image
    faction.flag_url if faction
  end

  def faction_rank
    target_faction = faction ? faction : Faction.find_by(name: "Default")
    target_faction.rank_by_level current_level
  end

  def rank_by_renown
    target_faction = faction ? faction : Faction.find_by(name: "Default")
    args = { renown: total_renown,
             secret_missions: total_secret_missions,
             level: current_level,
             use_old_rank: user.character_style_old? }
    target_faction.rank_by_renown args
  end

  def faction_name
    if faction_override
      faction_override
    elsif faction
      faction.name
    else
      'None'
    end
  end

end
