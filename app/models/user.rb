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
  has_many :c1circle_checklists
  has_one :api_token, dependent: :destroy

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9\-_]+\Z/i }, length: { minimum: 4 }

  # ----------------------------------------------------------
  # Scope
  # ----------------------------------------------------------
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  # ----------------------------------------------------------
  # Callback
  # ----------------------------------------------------------
  after_create :add_role_normal

  def remember_me
    true
  end

  def undefined_passsword?
    !!/\A.+@undefined\z/i.match(email)
  end

  private

  def add_role_normal
    add_role :normal
  end
end
