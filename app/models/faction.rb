class Faction < ActiveRecord::Base
  has_many :characters
  has_many :faction_ranks

  RANKS = [{ numerical_rank: 1, renown:  0, secret_missions:  0, level:  0 },
          { numerical_rank: 2, renown:  3, secret_missions:  0, level:  0 },
          { numerical_rank: 3, renown: 10, secret_missions:  1, level:  5 },
          { numerical_rank: 4, renown: 25, secret_missions:  3, level: 11 },
          { numerical_rank: 5, renown: 50, secret_missions: 10, level: 17 }]

  def rank(renown:, secret_missions:, level:)
    rank_number = numerical_rank(renown, secret_missions, level)
    return "Unknown" if rank_number == 0

    faction_rank = faction_ranks.find_by numerical_rank: rank_number
    return "rank #{rank_number}" unless faction_rank && faction_rank.name

   "#{faction_rank.name} (rank #{rank_number})"
  end

  def numerical_rank(renown, secret_missions, level)
    numerical_rank = 0

    RANKS.each_with_index do |rank|
      if renown < rank[:renown] || secret_missions < rank[:secret_missions] || level < rank[:level]
        return numerical_rank
      end

      numerical_rank = rank[:numerical_rank]
    end

    return numerical_rank
  end
end