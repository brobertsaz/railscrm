class TasksController < ApplicationController

  def new
    @task = Task.new
    @task_due_dates = Task.due_dates
    @task_types = Task.task_type
    @task_owners = User.all.map(&:email)
    @leads = Lead.all.map(&:email)
  end
  
  def show
    @task = Task.find params[:id]
    @task_due_dates = Task.due_dates
    @task_types = Task.task_type
    @task_owners = User.all.map(&:email)
    @leads = Lead.all.map(&:email)
  end

  def create
    @task = Task.create params[:task]
    task_owner = User.where(email: @task.assigned_to).first
    if @task.save
      redirect_to tasks_path, flash: { notice: 'New Task Created'}
      TaskMailer.notify_new_task(task_owner, @task).deliver
    else
      render :new
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to tasks_path, flash: { notice: 'Task Deleted'}
  end

  def update
    @task = Task.find params[:id]
    if @task.update_attributes params[:task]
      task_owner = User.where(email: @task.assigned_to).first
      redirect_to tasks_path, flash: { notice: 'Task Updated'}
      TaskMailer.notify_updated_task(task_owner, @task).deliver
    else
      redirect_to task_path, flash: { notice: 'Unable to update task.'}
    end
  end

  def index
    @tasks = Task.all
  end
end
