class CreateC1circleChecklist < ActiveRecord::Migration
  def change
    create_table :c1circle_checklists do |t|
      t.integer :user_id,     null: false
      t.integer :comic1_id,   null: false
      t.integer :c1layout_id, null: false
      t.string :space_no_sub, null: false
      t.string :circle_name,  null: false
      t.string :circle_url
      t.string :comment
      t.string :cost
      t.string :color,        null: false, default: :black
      t.integer :rank,        null: false, default: 1

      t.timestamps
    end

    add_index :c1circle_checklists, :user_id
    add_index :c1circle_checklists, :comic1_id
    add_index :c1circle_checklists, :c1layout_id
    add_index :c1circle_checklists, :circle_name
    add_index :c1circle_checklists, :color
    add_index :c1circle_checklists, :rank
  end
end
