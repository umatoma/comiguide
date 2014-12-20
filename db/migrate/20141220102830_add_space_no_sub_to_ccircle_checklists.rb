class AddSpaceNoSubToCcircleChecklists < ActiveRecord::Migration
  def change
    add_column :ccircle_checklists, :space_no_sub, :integer, null: false, default: 0, after: :clayout_id
  end
end
