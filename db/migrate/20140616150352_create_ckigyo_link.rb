class CreateCkigyoLink < ActiveRecord::Migration
  def change
    create_table :ckigyo_links do |t|
      t.integer :ckigyo_id,  null: false
      t.string  :url,        null: false

      t.timestamps
    end

    add_index :ckigyo_links, :ckigyo_id
    add_index :ckigyo_links, [:ckigyo_id, :url], unique: true
  end
end
