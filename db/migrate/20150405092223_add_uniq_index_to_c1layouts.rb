class AddUniqIndexToC1layouts < ActiveRecord::Migration
  def change
    add_index :c1layouts, [:c1block_id, :space_no], unique: true
  end
end
