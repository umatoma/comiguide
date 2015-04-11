class AddTargetToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :target, :integer, null: false, default: 0
    add_index :notifications, :target
  end
end
