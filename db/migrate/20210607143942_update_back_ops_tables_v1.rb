# frozen_string_literal: true

class UpdateBackOpsTablesV1 < ActiveRecord::Migration[6.1]
  def change
    add_column :back_ops_operations, :next_action_id, :integer, limit: 8
    rename_column :back_ops_operations, :context, :globals

    add_column :back_ops_actions, :branch, :text
    add_column :back_ops_actions, :perform_at, :timestamp
  end
end