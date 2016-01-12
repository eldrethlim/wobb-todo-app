module FlashMessageHelper

  def display_message(value)

    return value unless value.kind_of?(Array)

    content_tag :ul do
      value.collect { |message| content_tag(:li, message) }.join.html_safe
    end
  end
end
