class CcircleChecklist < ActiveRecord::Base
  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :user
  belongs_to :comiket
  belongs_to :clayout

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id,     presence: true, numericality: true
  validates :comiket_id,  presence: true, numericality: true
  validates :clayout_id,  presence: true, numericality: true
  validates :day,         presence: true, numericality: true
  validates :circle_name, presence: true
  validates :color,       presence: true
  validates :rank,        presence: true, numericality: true
end
