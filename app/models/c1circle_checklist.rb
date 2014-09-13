class C1circleChecklist < ActiveRecord::Base
  include Colors

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :user
  belongs_to :comic1
  belongs_to :c1layout

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id,      presence: true, numericality: true
  validates :comic1_id,    presence: true, numericality: true
  validates :c1layout_id,   presence: true, numericality: true
  validates :space_no_sub, presence: true, numericality: true
  validates :circle_name,  presence: true
  validates :color,        presence: true
  validates :rank,         presence: true, numericality: true
end
