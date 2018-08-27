module ApplicationHelper
  require 'redcarpet/render_strip'

  def display_attribute(attribute_name, attribute_value, options = {})
    ("<div class='row " + options[:class].to_s + "'>
        <div class='col-xs-5'>
          <strong>" + attribute_name + ":</strong>
        </div>
        <div class='col-xs-7'>" +
          attribute_value.to_s +
        "</div>
      </div>").html_safe
  end

  def display_attribute_small(attribute_name, attribute_value, options = {})
    ("<div class='row " + options[:class].to_s + "'>
        <div class='col-xs-7'>
          <strong>" + attribute_name + ":</strong>
        </div>
        <div class='col-xs-5'>" +
          attribute_value.to_s +
        "</div>
      </div>").html_safe
  end

  def display_attribute_ary(attribute_name, attribute_value, options = {})
    attribute_value = [] unless attribute_value

    ("<div class='row " + options[:class].to_s + "'>
        <div class='col-xs-5'>
          <strong>" + attribute_name + ":</strong>
        </div>
        <div class='col-xs-7'>" +
          attribute_value.inject{ |result, n| result + ",<br>" + n }.to_s +
        "</div>
      </div>").html_safe
  end

  def display_treasure_checkpoints(attribute_name, character, options = {})
    attribute_value = character.treasure_checkpoints(tier: 1).to_s + "/" +
                      character.treasure_checkpoints(tier: 2).to_s + "/" +
                      character.treasure_checkpoints(tier: 3).to_s + "/" +
                      character.treasure_checkpoints(tier: 4).to_s

    ("<div class='row " + options[:class].to_s + "'>
        <div class='col-xs-5'>
          <strong>" + attribute_name + ":</strong>
        </div>
        <div class='col-xs-7'>" +
          attribute_value +
        "</div>
      </div>").html_safe
  end

  def display_attribute_for_print(attribute_name, attribute_value)
    attribute_value = '&nbsp' if attribute_value.nil? || attribute_value == ''
    ("<div class='text-box'>" + attribute_value.to_s + '</div>' \
     '<label>' + attribute_name + '</label>').html_safe
  end

  def make_dm_and_dci_string(dm, dci)
    string = ''
    string += dm          if dm && dm != ''
    string = string + ' - ' + dci if dci && dci != ''
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: {
        rel: 'nofollow',
        target: "_blank",
      },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def strip_markdown(text)
    renderer = Redcarpet::Render::StripDown
    markdown = Redcarpet::Markdown.new(renderer)

    markdown.render(text)
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

  def link_to_character_if_public(character, user, current_user)
    if character
      if character.publicly_visible? || character.user.publicly_visible_characters? || @user == current_user
        link_to character.name, [user, character]
      else
        character.name
      end
    end
  end

  def sort_params(params)
    params.permit(q: [:s])
  end

end
