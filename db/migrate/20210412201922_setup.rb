class Setup < ActiveRecord::Migration[6.1]
  def change

    create_table :users do |t|
      t.string :name
      t.string :auth_token, limit: 32
      t.timestamps
    end

    add_index :users, :auth_token

    create_table :channels do |t|
      t.string :name
      t.timestamps
    end

    create_table :channel_users do |t|
      t.integer :user_id, limit: 8
      t.integer :channel_id, limit: 8
      t.timestamps
    end

    add_index :channel_users, :user_id
    add_index :channel_users, :channel_id

    create_table :messages do |t|
      t.integer :channel_user_id, limit: 8
      t.text :body
      t.text :image_url
      t.timestamps
    end

    add_index :messages, :channel_user_id
  end
end
