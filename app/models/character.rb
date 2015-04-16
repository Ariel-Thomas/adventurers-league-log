class Character < ActiveRecord::Base
  belongs_to :user
  has_many   :log_entries
  validates :name, presence: true

  FACTIONS = ["Harpers", "Order of the Guantlet", "Emerald Enclave", "Lord's Alliance", "Zhentarim"]
  FACTION_IMAGES = {"Harpers":               "harpers.jpg",
                    "Order of the Guantlet": "orderofthegauntlet.jpg",
                    "Emerald Enclave":       "emeraldenclave.jpg",
                    "Lord's Alliance":       "lordsalliance.jpg",
                    "Zhentarim":             "zhentarim.jpg"               }

  XP_BY_LEVEL =
   [0, 300, 900, 2700, 6500, 14000, 23000, 34000, 48000, 64000, 85000, 100000, 120000, 140000, 165000, 195000, 225000, 265000, 305000, 355000]

  def self.faction_list
    FACTIONS
  end

  def faction_image
    FACTION_IMAGES[faction.to_sym]
  end

  def total_xp
    log_entries.pluck(:xp_gained).compact.inject(:+) || 0
  end

  def current_level
    current_xp = total_xp

    XP_BY_LEVEL.each_with_index do |xp_amount, index|
      if current_xp < xp_amount
        return index
      end
    end

    return 20
  end

  def xp_to_next_level
    XP_BY_LEVEL[current_level] - total_xp
  end

  def xp_for_next_level
    XP_BY_LEVEL[current_level]
  end

  def total_gp
    log_entries.pluck(:gp_gained).compact.inject(:+) || 0
  end

  def total_renown
    log_entries.pluck(:renown_gained).compact.inject(:+) || 0
  end

  def total_downtime
    log_entries.pluck(:downtime_gained).compact.inject(:+) || 0
  end

  def total_magic_items
    log_entries.pluck(:num_magic_items_gained).compact.inject(:+) || 0
  end

  def magic_items_list
    list = log_entries.pluck(:desc_magic_items_gained).delete_if{ |x| x == "" }.join(',')
    if (list == "")
      return "None"
    else
      return list
    end
  end
end
