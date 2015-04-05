class ChangeColumnDefaults < ActiveRecord::Migration
  def change
    change_column_default :c1layouts, :layout, 1
    change_column_default :c1layouts, :pos_x, 0
    change_column_default :c1layouts, :pos_y, 0
  end
end
