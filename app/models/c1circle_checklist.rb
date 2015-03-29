# == Schema Information
#
# Table name: c1circle_checklists
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  comic1_id    :integer          not null
#  c1layout_id  :integer          not null
#  space_no_sub :integer          not null
#  circle_name  :string(255)      not null
#  circle_url   :string(255)
#  comment      :string(255)
#  cost         :string(255)
#  color        :string(255)      default("black"), not null
#  rank         :integer          default(1), not null
#  created_at   :datetime
#  updated_at   :datetime
#

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
  validates :c1layout_id,  presence: true, numericality: true
  validates :space_no_sub, presence: true
  validates :circle_name,  presence: true
  validates :color,        presence: true
  validates :rank,         presence: true, numericality: true

  enum space_no_sub: [:a, :b]

  def self.csv_for_download(c1circle_checklists)
    csv_data = CSV.generate do |csv|
      c1circle_checklists.each do |checklist|
        csv << [
          checklist.c1layout.c1block.name,
          checklist.c1layout.space_no,
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

  def layout_info_simple
    "#{c1layout.layout_info_simple}#{space_no_sub}"
  end
end
