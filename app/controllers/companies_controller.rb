class CompaniesController < ApplicationController
  def index

  end

  def show

  end

  def new
    if current_user
      @company = Company.new
      @user = current_user
      render :new
    else
      flash[:alert] = "Please login/sign up in order to create a company"
      redirect_to root_path
    end
  end

  def create
    company = Company.new(company_params)
    company.user = current_user
    if company.save
      flash[:notice] = "Company saved successfully"
      redirect_to root_path
    else
      flash[:error] = company.errors.full_messages.join(", ")
      redirect_to new_company_path
    end
  end

  def edit

  end

  def update

  end

  private

  def company_params
    params.require(:company).permit(:name, :country, :state, :city, :description, :website, :logo, :user_id)
  end

end
