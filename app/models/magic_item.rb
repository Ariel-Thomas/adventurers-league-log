class MagicItem < ActiveRecord::Base
  belongs_to :log_entry
  belongs_to :trade_log_entry
  belongs_to :purchase_log_entry
  belongs_to :character

  enum rarity: [:common, :uncommon, :rare, :very_rare, :legendary, :unique]

  scope :traded, -> { where.not(trade_log_entry_id: nil) }
  scope :not_traded, -> { where(trade_log_entry_id: nil) }
  scope :purchased, -> { where.not(purchase_log_entry_id: nil).or(where(purchased: true)) }
  scope :unlocked, -> { where(purchased: false, purchase_log_entry_id: nil) }

  def traded_or_purchased?
    !trade_log_entry_id.nil? || !purchase_log_entry_id.nil?
  end

  class << self
    def magic_items_list
      list = purchased.not_traded.pluck(:name).join(', ')

      if list == ''
        return 'None'
      else
        return list
      end
    end
  end
end
