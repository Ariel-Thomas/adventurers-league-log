module Character::LifestyleConcern
  def lifestyle_name
    return lifestyle_name_from_level(current_level) if user.character_style_season8?

    if lifestyle_override
      lifestyle_override
    elsif lifestyle
      lifestyle.name
    else
      'None'
    end
  end

  def lifestyle_name_from_level(level)
    return "Modest"       if level <= 4
    return "Comfortable"  if level <= 10
    return "Wealthy"      if level <= 16
    return "Aristocratic"
  end


end
