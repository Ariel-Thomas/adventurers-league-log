class MagicItem < ActiveRecord::Base
  belongs_to :log_entry
  belongs_to :trade_log_entry
  belongs_to :character

  enum rarity: [:common, :uncommon, :rare, :very_rare, :legendary, :unique]

  scope :purchased, -> { where(purchased: true) }
  scope :unlocked, -> { where(purchased: false) }
end
