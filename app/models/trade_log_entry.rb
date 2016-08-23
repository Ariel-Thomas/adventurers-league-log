class TradeLogEntry < LogEntry
  has_one :traded_magic_item, inverse_of: :trade_log_entry, class_name: MagicItem

  def user
    character.user
  end

  def is_trade_log_entry?
    true
  end

  def magic_items_list
    traded_magic_item_name   = traded_magic_item.name if traded_magic_item
    received_magic_item      = magic_items.first
    received_magic_item_name = received_magic_item ? received_magic_item.name : ''

    "#{traded_magic_item_name} > #{received_magic_item_name}"
  end
end
