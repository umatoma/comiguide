# == Schema Information
#
# Table name: cblocks
#
#  id       :integer          not null, primary key
#  carea_id :integer          not null
#  name     :string(255)      not null
#  pos_x    :integer          not null
#  pos_y    :integer          not null
#

class Cblock < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  MARGIN_X = 20
  MARGIN_Y = 30

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :carea
  has_many :clayouts

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :carea_id, presence: true, numericality: true
  validates :name,     presence: true
  validates :pos_x,    presence: true, numericality: true
  validates :pos_y,    presence: true, numericality: true

  def scaled_pos_x
    pos_x - MARGIN_X
  end

  def scaled_pos_y
    pos_y - MARGIN_Y
  end
end
