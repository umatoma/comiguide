# == Schema Information
#
# Table name: notifications
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  content      :text             not null
#  status       :integer          default(1), not null
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Notification < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  STATUS = {
    publish: 1,
    draft: 2,
    close: 3
  }.freeze

  STATUS_NAME = {
    1 => 'publish',
    2 => 'draft',
    3 => 'close'
  }.freeze

  # ----------------------------------------------------------
  # Enum
  # ----------------------------------------------------------
  enum target: [:web, :android]

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :title,   presence: true
  validates :content, presence: true
  validates :status,  presence: true, numericality: true

  # ----------------------------------------------------------
  # Scope
  # ----------------------------------------------------------
  scope :publish, -> { where(status: STATUS[:publish]) }
  scope :draft,   -> { where(status: STATUS[:draft]) }
  scope :close,   -> { where(status: STATUS[:close]) }
  scope :recent,  -> { where(Notification.arel_table[:created_at].gt(1.month.ago)) }

  default_scope { order(id: :desc) }

  # ----------------------------------------------------------
  # Callback
  # ----------------------------------------------------------
  before_create :set_published_at, if: -> { publish? }
  before_update :set_published_at, if: -> { status_changed? && publish? }

  def publish?
    status == STATUS[:publish]
  end

  def status_name
    STATUS_NAME[status]
  end

  private

  def set_published_at
    self.published_at = DateTime.now
  end
end
