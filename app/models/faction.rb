class Faction < ActiveRecord::Base
  has_many :characters

  RANKS =  [{ rank_name: "Rank 1", renown:  0, secret_missions:  0, level:  0 },
  			{ rank_name: "Rank 2", renown:  3, secret_missions:  0, level:  0 },
  			{ rank_name: "Rank 3", renown: 10, secret_missions:  1, level:  5 },
  			{ rank_name: "Rank 4", renown: 25, secret_missions:  3, level: 11 },
  			{ rank_name: "Rank 5", renown: 50, secret_missions: 10, level: 17 }]

  def rank(renown:,secret_missions:,level:)
  	rank_name = "Unknown"

  	RANKS.each_with_index do |rank|
      if renown < rank[:renown] || secret_missions < rank[:secret_missions] || level < rank[:level]
        return rank_name
      end

      rank_name = rank[:rank_name]
    end

    return rank_name
  end
end