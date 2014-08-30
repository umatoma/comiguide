class Comic1 < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  MAIN_ID = 8

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  has_many :c1blocks
  has_many :c1layouts, through: :c1blocks
  has_many :c1circle_checklists

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :event_no,   presence: true, numericality: true, uniqueness: true
  validates :event_name, presence: true
end
