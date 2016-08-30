class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :characters
  has_many :campaign_participations, through: :characters
  has_many :character_campaigns, through: :characters, source: :campaigns

  has_many :player_dms

  has_many :dm_log_entries
  has_many :campaigns
end
