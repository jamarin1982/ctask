class Task < ApplicationRecord
  include PgSearch::Model
  include AASM
  include States

  pg_search_scope :search_full_text, against: {
    title: "A",
    description: "B"
  }

  has_one_attached :photo

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :category
  belongs_to :user, default: -> { Current.user }

  def owner?
    user_id == Current.user&.id
  end
end
