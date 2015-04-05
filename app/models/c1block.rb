# == Schema Information
#
# Table name: c1blocks
#
#  id        :integer          not null, primary key
#  comic1_id :integer          not null
#  name      :string(255)      not null
#  pos_x     :integer          not null
#  pos_y     :integer          not null
#

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
  validates :comic1_id, presence: true, numericality: true, uniqueness: { scope: :name }
  validates :name,      presence: true
  validates :pos_x,     presence: true, numericality: true
  validates :pos_y,     presence: true, numericality: true
end
