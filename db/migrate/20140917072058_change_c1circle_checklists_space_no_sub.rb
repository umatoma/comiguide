class ChangeC1circleChecklistsSpaceNoSub < ActiveRecord::Migration
  def up
    change_column :c1circle_checklists, :space_no_sub, :integer
  end


  def down
    change_column :c1circle_checklists, :space_no_sub, :string
  end
end
