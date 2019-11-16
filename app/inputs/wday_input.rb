class WdayInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    @builder.select(attribute_name, I18n.t(:"date.day_names").each_with_index.to_a, {}, input_html_options)
  end

  def input_html_options
    super.merge({class: 'form-control'})
  end
end