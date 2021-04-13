class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return true if value.blank?

    begin
      uri = URI.parse(value)
      return true if uri.is_a?(URI::HTTP) && !uri.host.nil?
      object.errors.add(attribute, (options[:message] || 'is invalid'))
    rescue URI::InvalidURIError
      object.errors.add(attribute, (options[:message] || 'is invalid'))
    end
  end
end