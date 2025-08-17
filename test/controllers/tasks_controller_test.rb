require "test_helper"
class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @task = tasks(:task_1)
    @category = categories(:cat_1)
  end
  test "render a list of tasks" do
    get tasks_path

    assert_response :success
    assert_select ".task", 5
    assert_select ".category", 3
  end

  test "render a list of tasks filtered by category" do
    get tasks_path(category_id: @category)

    assert_response :success
    assert_select ".task", 5
  end

  test "render a detailed task page" do
    get task_path(@task)

    assert_response :success
    assert_select ".title", "Tarea 1"
    assert_select ".description", "Realizar una vista de tareas"
    assert_select ".start_date", "2025-08-07 00:00:00 UTC"
    assert_select ".end_date", "2025-08-07 00:00:00 UTC"
  end

  test "render a new task form" do
    get new_task_path

    assert_response :success
    assert_select "form"
  end

  test "allow to create a new task" do
    post tasks_path, params: {
      task: {
        title: "Tarea 4",
        description: "Crear formulario para editar una tarea",
        start_date: "2025-08-11 00:00:00 UTC",
        end_date: "2025-08-11 00:00:00 UTC",
        category_id: categories(:cat_1).id,
        user_id: users(:test).id
      }
    }

    # assert_response :success
    puts assigns(:task).errors.full_messages

    assert_redirected_to tasks_path
    assert_equal flash[:notice], "La tarea se ha creado correctamente"
  end

  test "does not allow to create a new task with empty fields" do
    post tasks_path, params: {
      task: {
        title: "",
        description: "Crear formulario para editar una tarea",
        start_date: nil,
        end_date: nil,
        category: nil,
        state: nil
      }
    }

    assert_response :unprocessable_content
  end

  test "render an edit task form" do
    get edit_task_path(@task)

    assert_response :success
    assert_select "form"
  end

  test "allow to udpate a task" do
    patch task_path(tasks(:task_1)), params: {
      task: {
        start_date: "2025-08-12 00:00:00 UTC",
        end_date: "2025-08-12 00:00:00 UTC"
      }
    }

    assert_redirected_to tasks_path
    assert_equal flash[:notice], "La tarea se ha actualizado correctamente"
  end

  test "does not allow to udpate a task with an invalid field" do
    patch task_path(@task), params: {
      task: {
        start_date: nil
      }
    }

    assert_response :unprocessable_content
  end

  test "can delete tasks" do
    assert_difference("Task.count", -1) do
      delete task_path(tasks(:task_9))
    end

    assert_redirected_to tasks_path
    assert_equal flash[:notice], "La tarea se ha eliminado correctamente"
  end

  test "search a task by query text" do
    get tasks_path(query_text: "Tarea 1")

    assert_response :success
    assert_select ".task", 1
    assert_select "h2", "Tarea 1"
  end
end
