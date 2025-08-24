# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  attr_reader :category
  def initialize(category: nil)
    @category = category
  end

  def title
    category ? category.name : t(".all")
  end

  def link
    category ? tasks_path(category_id: category.id) : tasks_path
  end

  def active?
    return true if !category && !params[:category_id]
    category&.id == params[:category_id].to_i
  end

  def background
    active? ? "bg-gray-300" : "bg-teal-500"
  end

  def classes
    "category text-white px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 #{background}"
  end
end
