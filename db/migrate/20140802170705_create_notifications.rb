class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :status, null: false, default: 1

      t.timestamps
    end

    add_index :notifications, :title
    add_index :notifications, :status
  end
end
