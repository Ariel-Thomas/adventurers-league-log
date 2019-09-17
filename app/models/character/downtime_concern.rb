module Character::DowntimeConcern
  def total_downtime
    log_entries.sum(:downtime_gained) +
      (add_downtime_per_level? ? total_downtime_from_levels(milestone_level, checkpoint_level) : 0)
  end

  def add_downtime_per_level?
    if user.automagic_downtime_toggle_override_no_override?
      automagic_downtime_toggle_yes?
    else
      user.automagic_downtime_toggle_override_yes?
    end
  end

  def total_downtime_from_levels(high, low)
    return 0 if high <= low
    downtime_from_level(high) + total_downtime_from_levels(high - 1, low)
  end

  def downtime_from_level(level)
    return    0 if level <= 1
    return   10 if level <= 4
    return   20 if level <= 10
    return   20 if level <= 16
    return   20
  end

end
