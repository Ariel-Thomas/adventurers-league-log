class TradeLogEntry < LogEntry
  has_one :traded_magic_item, inverse_of: :trade_log_entry, class_name: MagicItem, dependent: :nullify

  def user
    character.user
  end

  def is_trade_log_entry?
    true
  end

  def num_magic_items_gained
    magic_items.count - (traded_magic_item.nil? ? 0 : 1)
  end

  def magic_items_list(char)
    traded_magic_item_name   = traded_magic_item.name if traded_magic_item
    received_magic_item      = magic_items.first
    received_magic_item_name = received_magic_item ? received_magic_item.name : ''
    list = "#{traded_magic_item_name} > #{received_magic_item_name}"

    if list == " > "
      ""
    else
      list
    end
  end
end
