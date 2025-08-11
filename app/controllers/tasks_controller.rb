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

        @pagy, @tasks = pagy(@tasks, limit: 5)

        respond_to do |format|
            format.html # GET
            format.turbo_stream # POST
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

    %i[
        verify unverify develop undevelop
        reject unreject deliver undeliver
    ].each do |event|
        define_method(event) do
            run_aasm_event(event)
        end
    end



    private
    def task_params
        params.require(:task).permit(:title, :description, :start_date, :end_date, :photo, :category_id)
    end

    def task
        @task = Task.find(params[:id])
    end

    def run_aasm_event(event)
        may_event = "may_#{event}?"
        bang_event = "#{event}!"
        notice_event = (event[-1]=="y" ? event[0..-2] + "i" : event) + "ed"

        if task.respond_to?(may_event) && task.send(may_event)
            task.send(bang_event)
            notice = t(".#{notice_event}")
        else
            notice = t(".not_#{notice_event}", default: t("common.error"))
        end
        redirect_to tasks_path, notice: notice, status: :see_other
    end
end
