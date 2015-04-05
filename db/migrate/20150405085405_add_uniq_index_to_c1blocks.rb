class AddUniqIndexToC1blocks < ActiveRecord::Migration
  def change
    add_index :c1blocks, [:comic1_id, :name], unique: true
  end
end
