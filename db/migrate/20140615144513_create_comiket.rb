class CreateComiket < ActiveRecord::Migration
  def change
    create_table :comikets do |t|
      t.integer  :event_no,   null: false
      t.string   :event_name, null: false
      t.integer  :kigyo_w,    null: false
      t.integer  :kigyo_h,    null: false
    end

    add_index :comikets, :event_no, unique: true
  end
end
