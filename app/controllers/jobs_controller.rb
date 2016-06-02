class JobsController < ApplicationController
  def index
     if params[:search]
       # call search method in model.rb
       @jobs = Job.search(params[:search]).order("created_at DESC")
     else
       @jobs = Job.all.order('created_at DESC')
     end
     render :index
  end

  def search
    render :search
  end

  def show
    @job = Job.find(params[:id])
    @user = User.find(@job.user_id)
    render :show
  end

  def new
    if current_user
      @job = Job.new
      @user = current_user
      @company = Company.find(params[:company_id]) 
      render :new
    else
      flash[:alert] = "Please login/sign up in order to create a job"
      redirect_to root_path
    end
  end

  def create
    job = Job.new(job_params)
    job.user = current_user
    if job.save
      flash[:notice] = "Job saved successfully"
      # redirect_to job_path
      redirect_to root_path
    else
      flash[:error] = job.errors.full_messages.join(", ")
      redirect_to new_job_path
    end
  end

  def edit
    @job = Job.find(params[:id])
    @user = current_user
    render :edit
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:notice] = "Job updated successfully"
      redirect_to root_path
    else
      flash[:error] = @job.erorrs.full_messages.join(", ")
      redirect_to edit_job_path
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.destroy
      flash[:notice]  = "Job deleted successfully"
      redirect_to root_path
    else
      flash[:error] = @job.errors.full_messages.join(", ")
    end
  end

  private

  def job_params
    params.require(:job).permit(:category, :title, :email, :phone_number, :description, :user_id, :company_id, :country, :state, :city)
  end
end
