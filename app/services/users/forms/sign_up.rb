module Users
  module Forms
    class SignUp < BaseForm

      # == Constants ============================================================

      # == Attributes ===========================================================

      attr_accessor :user

      property :name, as: :string, transform: [:strip]

      # == Extensions ===========================================================

      # == Aliases ==============================================================

      # == Validations ==========================================================

      validates :name, presence: true

      validate :validate_name_unique

      # == Callbacks ============================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================

      def save
        return false unless valid?
        self.user = User.create!(name: name)
        true
      end

      private

      def validate_name_unique
        return true if name.blank?
        errors.add(:name, 'must be unique') if User.exists?(name: name)
      end

    end
  end
end
