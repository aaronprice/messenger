module Chats
  module Operations
    class UpdateChannelStats
      def self.call(channel)
        BackOps::Worker.perform_async({
          channel_id: channel.id
        }, {
          main: [
            Chats::Actions::UpdateChannelStats::RecalculateStats
          ]
        })
      end
    end
  end
end
