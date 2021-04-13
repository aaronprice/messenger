# frozen_string_literal: true

class CreateBackOpsTables < ActiveRecord::Migration[6.1]
  def change
    create_table :back_ops_operations do |t|
      t.string :name
      t.string :params_hash
      t.jsonb :context, null: false, default: {}
      t.timestamp :completed_at

      t.timestamps
    end

    add_index :back_ops_operations, [:name, :params_hash]
    
    create_table :back_ops_actions do |t|
      t.integer :operation_id, limit: 8
      t.integer :order, null: false, default: 0
      t.text :name
      t.text :error_message
      t.text :stack_trace
      t.timestamp :errored_at
      t.timestamp :completed_at
      t.integer :attempts_count, null: false, default: 0

      t.timestamps
    end

    add_index :back_ops_actions, :operation_id
  end
end