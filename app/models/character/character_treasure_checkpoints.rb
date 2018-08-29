module Character::CharacterTreasureCheckpoints
  TREASURE_TIERS = [:tier1_treasure_checkpoints, :tier2_treasure_checkpoints, :tier3_treasure_checkpoints, :tier4_treasure_checkpoints]
  def treasure_checkpoints(tier:)
    log_entries.where(treasure_tier: tier).sum(:treasure_checkpoints) - log_entries.sum(TREASURE_TIERS[tier - 1])
  end

  def total_treasure_checkpoints
    log_entries.sum(:treasure_checkpoints)
  end
end
