class LogAssignment < ActiveRecord::Base
  belongs_to :log_entry, required: true
  belongs_to :character, required: true

  has_one :user, through: :character
end
