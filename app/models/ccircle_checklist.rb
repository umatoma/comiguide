# == Schema Information
#
# Table name: ccircle_checklists
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  comiket_id   :integer          not null
#  clayout_id   :integer          not null
#  space_no_sub :integer          default(0), not null
#  day          :integer          not null
#  circle_name  :string(255)      not null
#  circle_url   :string(255)
#  comment      :string(255)
#  cost         :string(255)
#  color        :string(255)      default("black"), not null
#  rank         :integer          default(1), not null
#  created_at   :datetime
#  updated_at   :datetime
#

class CcircleChecklist < ActiveRecord::Base
  include Colors

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :user
  belongs_to :comiket
  belongs_to :clayout

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id,      presence: true, numericality: true
  validates :comiket_id,   presence: true, numericality: true
  validates :clayout_id,   presence: true, numericality: true
  validates :space_no_sub, presence: true
  validates :day,          presence: true, numericality: true
  validates :circle_name,  presence: true
  validates :color,        presence: true
  validates :rank,         presence: true, numericality: true

  enum space_no_sub: [:a, :b]

  def self.csv_for_download(ccircle_checklists)
    csv_data = CSV.generate do |csv|
      ccircle_checklists.each do |checklist|
        csv << [
          checklist.day_name,
          checklist.clayout.cblock.carea.name,
          checklist.clayout.cblock.name,
          checklist.clayout.space_no,
          checklist.space_no_sub,
          checklist.circle_name,
          checklist.circle_url,
          checklist.comment,
          checklist.cost,
          checklist.color
        ]
      end
    end
    csv_data.encode(Encoding::SJIS)
  end

  def day_name
    "#{day}日目"
  end

  def layout_info_simple
    "#{clayout.layout_info_simple}#{space_no_sub}"
  end
end
