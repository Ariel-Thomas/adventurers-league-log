class PurchaseLogEntry < LogEntry
  has_one :purchased_magic_item, inverse_of: :purchase_log_entry, class_name: 'MagicItem', dependent: :nullify
  accepts_nested_attributes_for :purchased_magic_item, reject_if: proc { |attributes| attributes[:name].blank? }, allow_destroy: true

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
