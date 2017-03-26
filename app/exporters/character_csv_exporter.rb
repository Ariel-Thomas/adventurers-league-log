class CharacterCsvExporter
  require 'csv'

  attr_accessor :character, :log_entries

  def initialize(character)
    @character   = character
    @log_entries = character.log_entries
  end

  def export
    character_attrs =  %w{ name race class_and_levels faction background lifestyle portrait_url publicly_visible }

    log_entry_attrs =  %w{ adventure_title session_num date_played
                           session_length_hours player_level
                           xp_gained gp_gained downtime_gained renown_gained num_secret_missions
                           location_played dm_name dm_dci_number
                           notes
                           type
                           date_dmed campaign_id }

    magic_item_attrs = %w{ name rarity location_found table table_result notes }

    CSV.generate(headers: true) do |csv|
      csv << character_attrs
      csv << character_attrs.map{ |attr| character.send(attr) }

      csv << log_entry_attrs + magic_item_attrs

      log_entries.each do |log_entry|
        row = log_entry_attrs.map{ |attr| log_entry.send(attr) }

        if log_entry.magic_items.present?
          log_entry.magic_items.each do |magic_item|
            row += magic_item_attrs.map{ |attr| magic_item.send(attr) }
          end
        end

        if log_entry.class == TradeLogEntry && log_entry.traded_magic_item.present?
          row += magic_item_attrs.map{ |attr| log_entry.traded_magic_item.send(attr) }
        end

        csv << row
      end
    end
  end
end