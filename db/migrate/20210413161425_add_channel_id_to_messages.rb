class AddChannelIdToMessages < ActiveRecord::Migration[6.1]
  def up
    add_column :messages, :channel_id, :integer, limit: 8
    add_column :messages, :user_id, :integer, limit: 8

    drop_table :channel_users
  end

  def down
    remove_column :messages, :channel_id
    remove_column :messages, :user_id
  end
end
