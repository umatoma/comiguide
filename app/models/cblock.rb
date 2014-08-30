class Cblock < ActiveRecord::Base
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
end
