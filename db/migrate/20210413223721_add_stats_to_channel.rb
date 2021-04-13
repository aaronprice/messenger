class AddStatsToChannel < ActiveRecord::Migration[6.1]
  def change
    add_column :channels, :messages_count, :integer, limit: 8, null: false, default: 0
    add_column :channels, :users_count, :integer, limit: 8, null: false, default: 0
  end
end
