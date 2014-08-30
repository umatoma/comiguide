class CreateC1circle < ActiveRecord::Migration
  def change
    create_table :c1circles do |t|
      t.integer :comic1_id, null: false
      t.integer :c1layout_id, null: false
      t.integer :space_no_sub, null: false
      t.string :name, null: false
      t.string :kana, null: false
      t.string :url

      t.timestamps
    end

    add_index :c1circles, :comic1_id
    add_index :c1circles, :c1layout_id
    add_index :c1circles, :name
    add_index :c1circles, :kana
  end
end
