module ApplicationHelper

  def link_to_character_if_public(character, user, current_user)
    if character
      if character.publicly_visible? || character.user.publicly_visible_characters? || @user == current_user
        link_to character.name, [user, character]
      else
        character.name
      end
    end
  end

  def make_dm_and_dci_string(dm, dci)
    string = ''
    string += dm          if dm && dm != ''
    string = string + ' - ' + dci if dci && dci != ''
  end

  def humanize_decimal(decimal_number)
    return nil unless decimal_number
    floor = decimal_number.floor

    if floor == decimal_number
      floor
    else
      decimal_number
    end
  end

  def format_date(date)
    date.strftime('%Y-%m-%d %H:%M') if date
  end

  def sort_params(params)
    params.permit(q: [:s])
  end

  def treasure_checkpoints_string(log_entries)
    treasure_checkpoints(log_entries, tier: 1).to_s + "/" +
    treasure_checkpoints(log_entries, tier: 2).to_s + "/" +
    treasure_checkpoints(log_entries, tier: 3).to_s + "/" +
    treasure_checkpoints(log_entries, tier: 4).to_s
  end

  def treasure_checkpoints(log_entries, tier:)
    log_entries.earned_treasure_checkpoints(tier: tier) - log_entries.spent_treasure_checkpoints(tier: tier)
  end

end
