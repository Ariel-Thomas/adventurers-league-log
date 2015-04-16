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
end
