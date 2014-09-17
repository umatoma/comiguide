class Notification < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  STATUS = {
    publish: 1,
    draft: 2,
    close: 3
  }

  STATUS_NAME = {
    1 => 'publish',
    2 => 'draft',
    3 => 'close'
  }

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
