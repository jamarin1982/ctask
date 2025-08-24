# frozen_string_literal: true

require "test_helper"

class CategoryComponentTest < ViewComponent::TestCase
  test "should render an empty category" do
    rendered = render_inline(CategoryComponent.new(category: nil)).to_html.squish
    expected = '<a class="category text-white px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-gray-300" href="/tasks">Todos</a>'
    assert_equal(expected, rendered)
  end

  test "should render a category" do
    category = Category.last
    rendered = render_inline(CategoryComponent.new(category: category)).to_html.squish
    expected = '<a class="category text-white px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-teal-500" href="/tasks?category_id='+"#{category.id}"+'">'+"#{category.name}</a>"
    assert_equal(expected, rendered)
  end
end
