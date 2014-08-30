class CreateCkigyoChecklist < ActiveRecord::Migration
  def change
    create_table :ckigyo_checklists do |t|
      t.integer :user_id,   null: false
      t.integer :ckigyo_id, null: false
      t.string :comment
      t.string :cost
      t.string :color,      null: false, default: :black
      t.integer :rank,      null: false, default: 1

      t.timestamps
    end

    add_index :ckigyo_checklists, :user_id
    add_index :ckigyo_checklists, :ckigyo_id
    add_index :ckigyo_checklists, :color
    add_index :ckigyo_checklists, :rank
  end
end
