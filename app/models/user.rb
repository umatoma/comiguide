class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  has_many :ckigyo_checklists
  has_many :ccircle_checklists

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :username, presence: true

  # ----------------------------------------------------------
  # Scope
  # ----------------------------------------------------------
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  # ----------------------------------------------------------
  # Callback
  # ----------------------------------------------------------
  after_create :add_role_normal

  # ----------------------------------------------------------
  # Private Method
  # ----------------------------------------------------------
  private

  def add_role_normal
    add_role :normal
  end
end
