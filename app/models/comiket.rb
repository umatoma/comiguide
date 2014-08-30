class Comiket < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  MAIN_ID = 85

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  has_many :ckigyos
  has_many :ckigyo_checklists, through: :ckigyos
  has_many :ccircle_checklists

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :event_no,   presence: true, numericality: true, uniqueness: true
  validates :event_name, presence: true
  validates :kigyo_w,    presence: true, numericality: true
  validates :kigyo_h,    presence: true, numericality: true
end
