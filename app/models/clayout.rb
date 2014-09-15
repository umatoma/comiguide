class Clayout < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  MARGIN_X = 20
  MARGIN_Y = 30

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :cblock
  has_many :ccircle_checklists

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :cblock_id, presence: true, numericality: true
  validates :space_no,  presence: true, numericality: true
  validates :layout,    presence: true, numericality: true
  validates :pos_x,     presence: true, numericality: true
  validates :pos_y,     presence: true, numericality: true

  def layout_info_simple
    "#{cblock.name} - #{space_no}"
  end

  def scaled_pos_x
    pos_x - MARGIN_X
  end

  def scaled_pos_y
    pos_y - MARGIN_Y
  end
end
