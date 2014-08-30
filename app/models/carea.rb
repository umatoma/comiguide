class Carea < ActiveRecord::Base
  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  has_many :cblocks
  has_many :clayouts, through: :cblocks

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :cmap_id,     presence: true, numericality: true
  validates :name,        presence: true
  validates :simple_name, presence: true
  validates :pos_x,       presence: true, numericality: true
  validates :pos_y,       presence: true, numericality: true
  validates :size_w,      presence: true, numericality: true
  validates :size_h,      presence: true, numericality: true
  validates :pos_x2,      presence: true, numericality: true
  validates :pos_y2,      presence: true, numericality: true
  validates :size_w2,     presence: true, numericality: true
  validates :size_h2,     presence: true, numericality: true
end
