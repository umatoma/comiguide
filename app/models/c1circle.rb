# == Schema Information
#
# Table name: c1circles
#
#  id           :integer          not null, primary key
#  comic1_id    :integer          not null
#  c1layout_id  :integer          not null
#  space_no_sub :integer          not null
#  name         :string(255)      not null
#  kana         :string(255)      not null
#  url          :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class C1circle < ActiveRecord::Base
  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :comic1
  belongs_to :c1layout

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :comic1_id,    presence: true, numericality: true
  validates :c1layout_id,  presence: true, numericality: true
  validates :space_no_sub, presence: true
  validates :name,         presence: true
  validates :kana,         presence: true

  enum space_no_sub: [:a, :b]
end
