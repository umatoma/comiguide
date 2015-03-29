class AddMapPosXAndMapPosYToCkigyos < ActiveRecord::Migration
  def change
    add_column :ckigyos, :map_pos_x, :integer, null: false, default: 0
    add_column :ckigyos, :map_pos_y, :integer, null: false, default: 0
  end
end
