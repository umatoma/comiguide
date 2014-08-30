class CreateCareas < ActiveRecord::Migration
  def change
    create_table :careas do |t|
      t.integer :cmap_id,     null: false
      t.string :name,         null: false
      t.string :simple_name,  null: false
      t.string :all_file_name
      t.integer :pos_x,       null: false
      t.integer :pos_y,       null: false
      t.integer :size_w,      null: false
      t.integer :size_h,      null: false
      t.integer :pos_x2,      null: false
      t.integer :pos_y2,      null: false
      t.integer :size_w2,     null: false
      t.integer :size_h2,     null: false
    end

    add_index :careas, :cmap_id
  end
end
