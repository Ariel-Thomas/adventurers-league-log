class MagicItem < ActiveRecord::Base
  belongs_to :log_entry
  has_one :character, through: :log_entry
end