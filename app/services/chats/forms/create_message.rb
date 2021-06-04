module Chats
  module Forms
    class CreateMessage < BaseForm

      # == Constants ============================================================

      # == Attributes ===========================================================

      attr_accessor :message

      property :current_user, as: :object

      property :channel_name, as: :string, transform: [:strip, :downcase]
      property :body, as: :string, transform: [:strip]
      property :image_url, as: :string, transform: [:strip]

      # == Extensions ===========================================================

      # == Aliases ==============================================================

      # == Validations ==========================================================

      validates :channel_name, presence: true
      validates :image_url, allow_blank: true, url_format: true

      validate :validate_either_body_or_image_url

      # == Callbacks ============================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================

      def save
        return false unless valid?
        create_message
        true
      end

      private

      def validate_either_body_or_image_url
        return true if body.present? || image_url.present?
        errors.add(:base, 'Either body or image_url is required')
      end

      def create_message
        ActiveRecord::Base.transaction do
          channel = Channel.create_or_find_by!(name: channel_name.strip.downcase)
          self.message = Message.create(channel: channel, user: current_user, body: body, image_url: image_url)

          Chats::Operations::UpdateChannelStats.call(channel)
        end
      end
    end
  end
end
