ActiveModel::Errors.class_eval do
  def generate_full_message(attribute, type = :invalid, options = {})
    message = generate_message(attribute, type, options)
    full_message(attribute, message)
  end
end