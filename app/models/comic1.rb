# == Schema Information
#
# Table name: comic1s
#
#  id         :integer          not null, primary key
#  event_no   :integer          not null
#  event_name :string(255)      not null
#

class Comic1 < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  MAIN_ID = 9

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  has_many :c1blocks
  has_many :c1layouts, through: :c1blocks
  has_many :c1circles
  has_many :c1circle_checklists

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :event_no,   presence: true, numericality: true, uniqueness: true
  validates :event_name, presence: true
end
