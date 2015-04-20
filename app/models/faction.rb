class Faction < ActiveRecord::Base
  has_many :characters
end