class CreateC1block < ActiveRecord::Migration
  def change
    create_table :c1blocks do |t|
      t.integer :comic1_id, null: false
      t.string :name,      null: false
      t.integer :pos_x,    null: false
      t.integer :pos_y,    null: false
    end

    add_index :c1blocks, :comic1_id
    add_index :c1blocks, :pos_x
    add_index :c1blocks, :pos_y
  end
end
