class MagicItem < ActiveRecord::Base
  belongs_to :log_entry
  belongs_to :trade_log_entry
  belongs_to :purchase_log_entry
  belongs_to :character

  enum rarity: [:common, :uncommon, :rare, :very_rare, :legendary, :unique]

  scope :purchased, -> { where.not(purchase_log_entry_id: nil).or(where(purchased: true)) }
  scope :unlocked, -> { where(purchased: false, purchase_log_entry_id: nil) }

  def traded_or_purchased?
    !trade_log_entry_id.nil? || !purchase_log_entry_id.nil?
  end
end
