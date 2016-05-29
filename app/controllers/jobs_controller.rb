class JobsController < ApplicationController
  def index
    @jobs = Job.all
    render :index
  end

  def show
    @job = job.find(params[:id])
    @user = User.find(@job.user_id)
    render :show
  end

  def new
    if current_user
      @job = job.new
      @user = current_user
      render :new
    else
      flash[:alert] = "Please login/sign up in order to create a job"
      redirect_to root_path
    end
  end

  def create
    job = job.new(job_params)
    job.user = current_user
    if job.save
      flash[:notice] = "job saved successfully"
      # redirect_to job_path
      redirect_to root_path
    else
      flash[:error] = job.errors.full_messages.join(", ")
      redirect_to new_job_path
    end
  end

  def edit
    @job = job.find(params[:id])
    @user = current_user
    render :edit
  end

  def update
    @job = job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:notice] = "job updated successfully"
      redirect_to root_path
    else
      flash[:error] = @job.erorrs.full_messages.join(", ")
      redirect_to edit_job_path
    end
  end

  def destroy
    @job = job.find(params[:id])
    if @job.destroy
      flash[:notice]  = "job deleted successfully"
      redirect_to root_path
    else
      flash[:error] = @job.errors.full_messages.join(", ")
    end
  end

  private

  def jobs_params
    params.require(:job).permit(:category, :title, :email, :phone_number, :description, :user_id)
  end
end
