module Character::GoldConcern
  def total_gp
    log_entries.sum(:gp_gained) +
      (add_gold_per_level? ? total_gp_from_levels(checkpoint_level, xp_level) : 0)
  end

  def add_gold_per_level?
    if user.automagic_gold_toggle_override_no_override?
      automagic_gold_toggle_yes?
    else
      user.automagic_gold_toggle_override_yes?
    end
  end

  def total_gp_from_levels(high, low)
    return 0 if high <= low
    gp_from_level(high) + total_gp_from_levels(high - 1, low)
  end

  def gp_from_level(level)
    return    0 if level <= 1
    return   75 if level <= 4
    return  150 if level <= 10
    return  550 if level <= 16
    return 5500
  end

end
