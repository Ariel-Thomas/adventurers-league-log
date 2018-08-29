module AttributeDisplayHelper
  def display_attribute(attribute_name, attribute_value, options = {})
    ("<div class='row " + options[:class].to_s + "'>
        <div class='#{name_class(options)}'>
          <strong>#{attribute_name}:</strong>
        </div>
        <div class='#{value_class(options)}'>" +
          attribute_value_for_display(attribute_value, options) +
        "</div>
      </div>").html_safe
  end

  def attribute_value_for_display(attribute_value, options = {})
    if options[:type] == :level && attribute_value > 20
      return "20 (+#{attribute_value - 20})"
    elsif options[:type] == :array
      attribute_value ||= []
      return attribute_value.inject{ |result, n| result + ",<br>" + n }.to_s
    else
      attribute_value.to_s
    end
  end

  def name_class(options = {})
    return 'col-xs-7' if options[:size] == :small
    'col-xs-5'
  end

  def value_class(options = {})
    return 'col-xs-5' if options[:size] == :small
    'col-xs-7'
  end

  def display_attribute_for_print(attribute_name, attribute_value)
    attribute_value = '&nbsp' if attribute_value.nil? || attribute_value == ''
    ("<div class='text-box'>" + attribute_value.to_s + '</div>' \
     '<label>' + attribute_name + '</label>').html_safe
  end
end
