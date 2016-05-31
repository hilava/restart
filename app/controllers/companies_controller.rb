class CompaniesController < ApplicationController
  def index

  end

  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs
    render :show
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
    # add https:// if the website starts with www
    if company.website.start_with?("www")
      company.website << "https://"
    end
    if company.save
      flash[:notice] = "Company saved successfully"
      redirect_to root_path
    else
      flash[:error] = company.errors.full_messages.join(", ")
      redirect_to new_company_path
    end
  end

  def search
    if params[:search]
      @companies = Company.search(params[:search]).order("name")
    else
      @companies = Company.all.order("name")
    end
    render :search
  end

  def edit

  end

  def update

  end


  private

  def company_params
    params.require(:company).permit(:name, :description, :website, :logo, :user_id)
  end

end
