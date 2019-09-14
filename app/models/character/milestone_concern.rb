module Character::MilestoneConcern
  def milestone_level
    checkpoint_level + total_milestones
  end

  def total_milestones
    total_milestones_from_logs + rounding_from_checkpoints
  end

  def total_milestones_from_logs
    log_entries.sum(:milestones_gained)
  end

  def rounding_from_checkpoints
    total_stuff = total_checkpoints_from_logs + total_xp
    return 0 if total_stuff == 0

    if round_checkpoints_up?
      1
    else
      0
    end
  end

end
