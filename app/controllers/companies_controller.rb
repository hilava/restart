class CompaniesController < ApplicationController
  before_filter :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, only: [:edit, :update, :destroy]

  def index

  end

  def show
    #@company = Company.find(params[:id])
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
    company.website = include_https?(company)
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

  def include_https?(company)
    # add https:// if the website starts with www
    if company.website.start_with?("www")
      company.website = "https://" + company.website
    else
      company.website
    end
  end

  def company_params
    params.require(:company).permit(:name, :description, :website, :logo, :user_id)
  end

  def set_company
    company_id = params[:id]
    @company = Company.find(company_id)
  end

  def authorize
    if @company.user_id != current_user.id
      flash[:alert] = "Only record owners can edit and delete records"
      redirect_to root_path
    end
  end

end
