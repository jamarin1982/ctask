class AddNullFalseToTaskFields < ActiveRecord::Migration[8.0]
  def change
    change_column_null :tasks, :title, false
    change_column_null :tasks, :description, false
    change_column_null :tasks, :start_date, false
    change_column_null :tasks, :end_date, false
  end
end
