class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP, message: :invalid }
  validates :username, presence: true, uniqueness: true,
    length: { in: 3..15 },
    format: {
      with: /\A[a-zA-Z0-9_]+\z/,
      message: :invalid
    }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  before_save :downcase_attributes

  has_many :tasks, dependent: :destroy

  private

  def downcase_attributes
    email.downcase!
    username.downcase!
  end
end
