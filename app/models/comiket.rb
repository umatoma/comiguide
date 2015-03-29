# == Schema Information
#
# Table name: comikets
#
#  id         :integer          not null, primary key
#  event_no   :integer          not null
#  event_name :string(255)      not null
#  kigyo_w    :integer          not null
#  kigyo_h    :integer          not null
#

class Comiket < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  MAIN_ID = 87

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
