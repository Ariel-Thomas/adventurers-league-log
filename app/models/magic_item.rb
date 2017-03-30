class MagicItem < ActiveRecord::Base
  belongs_to :log_entry
  belongs_to :trade_log_entry
  has_one :character

  enum rarity: [:common, :uncommon, :rare, :very_rare, :legendary]
end
