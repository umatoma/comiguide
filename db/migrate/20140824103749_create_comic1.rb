class CreateComic1 < ActiveRecord::Migration
  def change
    create_table :comic1s do |t|
      t.integer  :event_no,   null: false
      t.string   :event_name, null: false
    end

    add_index :comic1s, :event_no, unique: true
  end
end
