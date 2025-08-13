class FindTasks
  attr_reader :tasks
  def initialize(tasks = initial_scope)
    @tasks = tasks
  end

  def call(params = {})
    scoped = tasks
    scoped = filter_by_category_id(scoped, params[:category_id])
    scoped = filter_by_query_text(scoped, params[:query_text])
  end

  private

  def initial_scope
    Task.with_attached_photo
  end

  def filter_by_category_id(scoped, category_id)
    return scoped unless category_id.present?

    scoped.where(category_id: category_id)
  end

  def filter_by_query_text(scoped, query_text)
    return scoped unless query_text.present?

    scoped.search_full_text(query_text)
  end
end
