class CreateC1layout < ActiveRecord::Migration
  def change
    create_table :c1layouts do |t|
      t.integer :c1block_id, null: false
      t.integer :space_no,  null: false
      t.integer :layout,    null: false
      t.integer :pos_x,     null: false
      t.integer :pos_y,     null: false
    end

    add_index :c1layouts, :c1block_id
    add_index :c1layouts, :space_no
    add_index :c1layouts, :layout
    add_index :c1layouts, :pos_x
    add_index :c1layouts, :pos_y
  end
end
