class AddMapPosXAndMapPosYToC1layouts < ActiveRecord::Migration
  def change
    add_column :c1layouts, :map_pos_x, :integer, null: false, default: 0
    add_column :c1layouts, :map_pos_y, :integer, null: false, default: 0
  end
end
