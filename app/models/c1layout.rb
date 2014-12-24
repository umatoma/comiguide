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
