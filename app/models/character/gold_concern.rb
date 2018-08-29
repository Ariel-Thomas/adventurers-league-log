module Character::GoldConcern
  def total_gp
    log_entries.sum(:gp_gained) + total_gp_from_levels(checkpoint_level, xp_level)
  end

  def total_gp_from_levels(high, low)
    return 0 if high <= low
    gp_from_level(high) + total_gp_from_levels(high - 1, low)
  end

  def gp_from_level(level)
    return    0 if level <= 1
    return   75 if level <= 4
    return  150 if level <= 10
    return  559 if level <= 16
    return 5500
  end

end
