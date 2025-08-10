class TasksController < ApplicationController
    def index
        @categories = Category.order(name: :asc).load_async
        @tasks = Task.all.with_attached_photo.order(start_date: :asc).load_async
        if params[:category_id].present?
            @tasks = @tasks.where(category_id: params[:category_id])
        end
        if params[:query_text].present?
            @tasks = @tasks.search_full_text(params[:query_text])
        end
    end

    def show
        task
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)

        if @task.save
            redirect_to tasks_path, notice: t(".created")
        else
            render :new, status: :unprocessable_content
        end
    end

    def edit
        task
    end

    def update
        if task.update(task_params)
            redirect_to tasks_path, notice: t(".updated")
        else
            render :edit, status: :unprocessable_content
        end
    end

    def destroy
        task.destroy
        redirect_to tasks_path, notice: t(".destroyed"), status: :see_other
    end

    private
    def task_params
        params.require(:task).permit(:title, :description, :start_date, :end_date, :photo, :category_id)
    end

    def task
        @task = Task.find(params[:id])
    end
end
