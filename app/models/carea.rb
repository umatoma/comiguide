# == Schema Information
#
# Table name: careas
#
#  id            :integer          not null, primary key
#  cmap_id       :integer          not null
#  name          :string(255)      not null
#  simple_name   :string(255)      not null
#  all_file_name :string(255)
#  pos_x         :integer          not null
#  pos_y         :integer          not null
#  size_w        :integer          not null
#  size_h        :integer          not null
#  pos_x2        :integer          not null
#  pos_y2        :integer          not null
#  size_w2       :integer          not null
#  size_h2       :integer          not null
#

class Carea < ActiveRecord::Base
  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  has_many :cblocks
  has_many :clayouts, through: :cblocks

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :cmap_id,     presence: true, numericality: true
  validates :name,        presence: true
  validates :simple_name, presence: true
  validates :pos_x,       presence: true, numericality: true
  validates :pos_y,       presence: true, numericality: true
  validates :size_w,      presence: true, numericality: true
  validates :size_h,      presence: true, numericality: true
  validates :pos_x2,      presence: true, numericality: true
  validates :pos_y2,      presence: true, numericality: true
  validates :size_w2,     presence: true, numericality: true
  validates :size_h2,     presence: true, numericality: true
end
