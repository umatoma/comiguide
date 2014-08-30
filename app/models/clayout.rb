class Clayout < ActiveRecord::Base
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
end
