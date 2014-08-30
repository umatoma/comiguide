class CreateCkigyo < ActiveRecord::Migration
  def change
    create_table :ckigyos do |t|
      t.integer :comiket_id, null: false
      t.integer :kigyo_no,   null: false
      t.string  :name,       null: false
      t.integer :x,          null: false
      t.integer :y,          null: false
      t.integer :w,          null: false, default: 1
      t.integer :h,          null: false, default: 1
    end

    add_index :ckigyos, :comiket_id
    add_index :ckigyos, :kigyo_no
    add_index :ckigyos, [:comiket_id, :kigyo_no], unique: true
  end
end
