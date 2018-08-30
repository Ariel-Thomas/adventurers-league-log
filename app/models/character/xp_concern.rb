module Character::XPConcern
  XP_BY_LEVEL =
    [0, 300, 900, 2700, 6500, 14_000, 23_000, 34_000, 48_000, 64_000, 85_000, 100_000, 120_000, 140_000, 165_000, 195_000, 225_000, 265_000, 305_000, 355_000].freeze

  def total_xp
    log_entries.sum(:xp_gained)
  end

  def xp_level
    current_xp = total_xp

    XP_BY_LEVEL.each_with_index do |xp_amount, index|
      return index if current_xp < xp_amount
    end

    20
  end

  def xp_to_next_level
    [xp_for_next_level - total_xp, 0].max
  end

  def fraction_of_xp_to_next_level
    level_fraction = Float(total_xp - XP_BY_LEVEL[[xp_level - 1,0].max]) / Float(xp_for_next_level - XP_BY_LEVEL[[xp_level - 1,0].max])
    return level_fraction / 2.0 if conversion_speed_slow?
    level_fraction
  end

  def xp_for_next_level
    XP_BY_LEVEL[xp_level] || 0
  end

end
