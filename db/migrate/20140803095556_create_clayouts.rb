class CreateClayouts < ActiveRecord::Migration
  def change
    create_table :clayouts do |t|
      t.integer :cblock_id, null: false
      t.integer :space_no,  null: false
      t.integer :layout,    null: false
      t.integer :pos_x,     null: false
      t.integer :pos_y,     null: false
    end

    add_index :clayouts, :cblock_id
    add_index :clayouts, :space_no
    add_index :clayouts, :layout
    add_index :clayouts, :pos_x
    add_index :clayouts, :pos_y
  end
end
