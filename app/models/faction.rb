class Faction < ActiveRecord::Base
  has_many :characters
  has_many :faction_ranks

  OLD_RANKS = [{ numerical_rank: 1, renown:  0, secret_missions:  0, level:  0 },
               { numerical_rank: 2, renown:  3, secret_missions:  0, level:  0 },
               { numerical_rank: 3, renown: 10, secret_missions:  1, level:  5 },
               { numerical_rank: 4, renown: 25, secret_missions:  3, level: 11 },
               { numerical_rank: 5, renown: 50, secret_missions: 10, level: 17 }]

  NEW_RANKS = [{ numerical_rank: 1, renown:  0, level:  0 },
               { numerical_rank: 2, renown:  2, level:  3 },
               { numerical_rank: 3, renown: 10, level:  8 },
               { numerical_rank: 4, renown: 20, level: 13 },
               { numerical_rank: 5, renown: 30, level: 18 }]

  def rank(renown:, secret_missions:, level:, use_old_rank:)
    rank_number = numerical_rank(renown, secret_missions, level, use_old_rank)
    return "Unknown" if rank_number == 0

    faction_rank = faction_ranks.find_by numerical_rank: rank_number
    return "rank #{rank_number}" unless faction_rank && faction_rank.name

   "#{faction_rank.name} (rank #{rank_number})"
  end

  def numerical_rank(renown, secret_missions, level, use_old_ranks)
    numerical_rank = 0

    if use_old_ranks
      OLD_RANKS.each_with_index do |rank|
        if renown < rank[:renown] || secret_missions < rank[:secret_missions] || level < rank[:level]
          return numerical_rank
        end

        numerical_rank = rank[:numerical_rank]
      end
    else
      NEW_RANKS.each_with_index do |rank|
        if renown < rank[:renown] || level < rank[:level]
          return numerical_rank
        end

        numerical_rank = rank[:numerical_rank]
      end
    end

    return numerical_rank
  end
end
