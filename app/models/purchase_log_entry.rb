class PurchaseLogEntry < LogEntry
  has_one :purchased_magic_item, inverse_of: :purchase_log_entry, class_name: 'MagicItem', dependent: :nullify

  def user
    character.user
  end

  def is_purchase_log_entry?
    true
  end

  def magic_items_list(char)
    purchased_magic_item.name if purchased_magic_item
  end
end
