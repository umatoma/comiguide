class AddUniqIndexToC1circles < ActiveRecord::Migration
  def change
    add_index :c1circles, [:c1layout_id, :space_no_sub], unique: true
  end
end
