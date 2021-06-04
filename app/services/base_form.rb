class BaseForm

  # == Constants ============================================================

  # == Attributes ===========================================================

  attr_accessor :arguments, :context, :params

  # == Extensions ===========================================================

  include ActiveModel::Model

  # == Aliases ==============================================================

  alias_method :active_model_valid?, :valid?

  # == Validations ==========================================================

  # == Class Methods ========================================================

  def self.property(attribute, options = { as: :string, transform: [] })
    define_method(attribute) do
      value = params[attribute]
      value = self.class.read_cast_value(value, options)
      value = self.class.transform_cast_value(value, options)
      value
    end

    define_method("#{attribute}=") do |value|
      params[attribute] = value
    end
  end

  def self.transform_cast_value(value, options)
    return nil if value.blank?

    [*options[:transform]].compact.each do |method|
      value = value.send(*[*method])
    end

    value
  end

  def self.read_cast_value(value, options)
    case options[:as]
    when :string
      cast_string(value)
    when :integer
      cast_integer(value)
    when :float
      cast_float(value)
    when :boolean
      cast_boolean(value)
    when :date
      cast_date(value)
    when :timestamp
      cast_timestamp(value)
    when :file
      cast_file(value)
    when :object
      value
    else
      fail "Unknown data type #{option[:as]}"
    end
  end

  def self.cast_string(value)
    value.to_s.presence
  end

  def self.cast_boolean(value)
    return nil if value.nil?
    return value if (value.is_a?(TrueClass) || value.is_a?(FalseClass))

    lower = value.to_s.downcase
    return true if lower == true
    return true if lower == "true"
    return true if lower == "yes"
    return true if lower == "1"
    return true if lower == "on"

    false
  end

  def self.cast_integer(value)
    return nil if value.blank?
    value.to_i
  end

  def self.cast_float(value)
    return nil if value.blank?
    value.to_f
  end

  def self.cast_date(value)
    return nil if value.blank?
    return value if value.is_a?(Date)
    Date.parse(value.to_s)
  end

  def self.cast_timestamp(value)
    return nil if value.blank?
    return value if value.is_a?(ActiveSupport::TimeWithZone)
    Time.zone.parse(value.to_s)
  end

  def self.cast_file(value)
    return nil if value.blank?
    return value if value.is_a?(ActionDispatch::Http::UploadedFile)

    # Resolve discrepancy between RSpec (hash) and the real world (object)
    tempfile = value.try(:tempfile) || value.try(:[], :tempfile)
    original_filename = value.try(:original_filename) || value.try(:[], :original_filename)
    content_type = value.try(:type) || value.try(:[], :type) || value.try(:content_type) || value.try(:[], :content_type)
    headers = value.try(:headers) || value.try(:[], :headers)

    return ActionDispatch::Http::UploadedFile.new({
      tempfile: tempfile,
      filename: original_filename,
      type: content_type,
      head: headers
    }) if value.is_a?(ApolloUploadServer::Wrappers::UploadedFile)

    raise ArgumentError, "#{value.inspect} must be implemented as a valid ActionDispatch::Http::UploadedFile"
  end

  # == Instance Methods =====================================================

  def initialize(arguments = {}, context = {})
    self.arguments = arguments.to_h
    self.context = context.to_h
    self.params = arguments.to_h.merge(context.to_h)
  end

  def persisted?
    false
  end

  def new_record?
    true
  end

  def valid?
    v = active_model_valid?
    move_non_argument_errors_to_base
    v
  end

  private

  def move_non_argument_errors_to_base
    base_keys = errors.attribute_names - arguments.keys - ['base', :base]

    base_keys.each do |key|
      errors[key].each_with_index do |error_key, index|
        errors.add(:base, "#{key.to_s.humanize} #{errors[key][index]}")
      end
      errors.delete(key)
    end
  end
end
