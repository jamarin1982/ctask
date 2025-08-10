class Task < ApplicationRecord
  include PgSearch::Model
  include AASM

  pg_search_scope :search_full_text, against: {
    title: "A",
    description: "B"
  }

  aasm column: "state" do
    state :scheduled, initial: true
    state :verified
    state :developed
    state :delivered
    state :rejected

    event :verify do
      transitions from: :scheduled, to: :verified
    end

    event :develop do
      transitions from: :verified, to: :developed
    end

    event :reject do
      transitions from: :verified, to: :rejected
    end

    event :deliver do
      transitions from: :developed, to: :delivered
    end

    event :unverify do
      transitions from: :verified, to: :scheduled
    end

    event :undevelop do
      transitions from: :developed, to: :verified
    end

    event :unreject do
      transitions from: :rejected, to: :verified
    end

    event :undeliver do
      transitions from: :delivered, to: :developed
    end
  end

  has_one_attached :photo

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :category
end
