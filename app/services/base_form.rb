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
      params[attribute]
    end

    define_method("#{attribute}=") do |value|
      params[attribute] = value
    end
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

  def graphql_errors
    errors.map do |error|
      OpenStruct.new(field: error.attribute, messages: [error.message])
    end
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
