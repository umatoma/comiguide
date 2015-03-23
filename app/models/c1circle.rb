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
