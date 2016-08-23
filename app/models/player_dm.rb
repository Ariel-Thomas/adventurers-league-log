class PlayerDm < ActiveRecord::Base
  belongs_to :user

  has_many :character_log_entries
end
