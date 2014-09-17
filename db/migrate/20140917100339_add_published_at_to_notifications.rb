class AddPublishedAtToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :published_at, :datetime, after: :status
  end
end
