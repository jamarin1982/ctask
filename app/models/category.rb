class Category < ApplicationRecord
  validates :name, presence: true

  has_many :tasks, dependent: :restrict_with_exception
end
