module ApplicationHelper
  def display_attribute attribute_name, attribute_value
    ("<div class='row'>
        <div class='col-sm-4'>
          <strong>" + attribute_name + ":</strong>
        </div>
        <div class='col-sm-8'>" +
          attribute_value.to_s +
        "</div>
      </div>").html_safe
  end
end
