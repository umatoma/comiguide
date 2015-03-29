# == Schema Information
#
# Table name: c1layouts
#
#  id         :integer          not null, primary key
#  c1block_id :integer          not null
#  space_no   :integer          not null
#  layout     :integer          not null
#  pos_x      :integer          not null
#  pos_y      :integer          not null
#  map_pos_x  :integer          default(0), not null
#  map_pos_y  :integer          default(0), not null
#

class C1layout < ActiveRecord::Base
  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :c1block
  has_many :c1circles
  has_many :c1circle_checklists

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :c1block_id, presence: true, numericality: true
  validates :space_no,   presence: true, numericality: true
  validates :layout,     presence: true, numericality: true
  validates :pos_x,      presence: true, numericality: true
  validates :pos_y,      presence: true, numericality: true

  def layout_info_simple
    "#{c1block.name} - #{space_no}"
  end
end
