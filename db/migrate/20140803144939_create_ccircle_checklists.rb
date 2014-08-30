class CreateCcircleChecklists < ActiveRecord::Migration
  def change
    create_table :ccircle_checklists do |t|
      t.integer :user_id,    null: false
      t.integer :comiket_id, null: false
      t.integer :clayout_id, null: false
      t.integer :day,        null: false
      t.string :circle_name, null: false
      t.string :circle_url
      t.string :comment
      t.string :cost
      t.string :color,       null: false, default: :black
      t.integer :rank,       null: false, default: 1

      t.timestamps
    end

    add_index :ccircle_checklists, :user_id
    add_index :ccircle_checklists, :comiket_id
    add_index :ccircle_checklists, :clayout_id
    add_index :ccircle_checklists, :day
    add_index :ccircle_checklists, :circle_name
    add_index :ccircle_checklists, :color
    add_index :ccircle_checklists, :rank
  end
end
