class User < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  before_create :set_defaults

  # == Class Methods ========================================================

  def self.new_auth_token
    SecureRandom.hex(16)
  end

  # == Instance Methods =====================================================

  def set_defaults
    self.auth_token ||= User.new_auth_token
  end
end