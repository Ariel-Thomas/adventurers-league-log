class Adventure < ActiveRecord::Base
  default_scope { order('position_num') }
end
