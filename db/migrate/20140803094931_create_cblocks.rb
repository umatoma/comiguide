class CreateCblocks < ActiveRecord::Migration
  def change
    create_table :cblocks do |t|
      t.integer :carea_id, null: false
      t.string :name,      null: false
      t.integer :pos_x,    null: false
      t.integer :pos_y,    null: false
    end

    add_index :cblocks, :carea_id
    add_index :cblocks, :pos_x
    add_index :cblocks, :pos_y
  end
end
