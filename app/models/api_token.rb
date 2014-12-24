class ApiToken < ActiveRecord::Base
  # ----------------------------------------------------------
  # Association
  # ----------------------------------------------------------
  belongs_to :user, -> { where.not(confirmed_at: nil) }

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id, presence: true
  validates :token, presence: true

  def set_token
    self.token = SecureRandom.uuid
  end
end
