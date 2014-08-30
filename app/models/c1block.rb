class C1block < ActiveRecord::Base
  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :comic1
  has_many :c1layouts
  has_many :c1circle_checklists, through: :c1layouts

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :comic1_id, presence: true, numericality: true
  validates :name,      presence: true
  validates :pos_x,     presence: true, numericality: true
  validates :pos_y,     presence: true, numericality: true
end
