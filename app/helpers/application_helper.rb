module ApplicationHelper
  def display_attribute attribute_name, attribute_value
    ("<div class='row'>
        <div class='col-xs-5'>
          <strong>" + attribute_name + ":</strong>
        </div>
        <div class='col-xs-7'>" +
          attribute_value.to_s +
        "</div>
      </div>").html_safe
  end


  def display_attribute_for_print attribute_name, attribute_value
    ("<div class='text-box'>" + attribute_value.to_s + "</div>" +
     "<label>" + attribute_name + "</label>").html_safe
  end

  def make_dm_and_dci_string dm, dci
    string = ""
    string = string + dm          if dm  && dm  != ''
    string = string + " - " + dci if dci && dci != ''
  end

  def humanize_decimal decimal_number
    return nil unless decimal_number
    floor = decimal_number.floor

    if (floor == decimal_number)
      floor
    else
      decimal_number
    end
  end

  def link_to_character_if_public character, user, current_user
    if character
      if (character.publicly_visible? || @user == current_user)
        link_to character.name, [user, character]
      else
        character.name
      end
    end
  end
end
