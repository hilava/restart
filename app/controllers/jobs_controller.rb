class JobsController < ApplicationController
  def index

  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  private

  def jobs_params
    params.require(:job).permit(:category, :title, :email, :phone_number, :description, :user_id)
  end
end
