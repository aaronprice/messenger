module Chats
  module Actions
    module UpdateChannelStats
      class RecalculateStats
        def self.call(operation)
           channel_id = operation.get(:channel_id)
           channel = Channel.find(channel_id)

           channel.users_count = Message.where(channel: channel).select("COUNT(DISTINCT user_id) AS users_count").reorder('').take.users_count
           channel.messages_count = channel.messages.count
           channel.save!
        end
      end
    end
  end
end