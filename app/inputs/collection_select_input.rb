class CollectionSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def input_html_classes
    super.push('chosen-select')
  end
end