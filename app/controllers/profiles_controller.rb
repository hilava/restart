class ProfilesController < ApplicationController
  before_filter :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, only: [:edit, :update, :destroy]

  def index
    if params[:search]
      # call search method in model.rb
      @profiles = Profile.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 6)
    else
      @profiles = Profile.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
    end
    render :index
  end

  def show
    if @profile
      @user = User.find(@profile.user_id)
      render :show
    else
      flash[:alert] = "Profile has not been found"
      redirect_to root_path
    end
  end

  def new
    if current_user
      # check if user already has a profile
      profile = Profile.find_by(user_id: current_user.id)
      if profile
        flash[:alert] = "You have already created a profile"
        redirect_to root_path
      else
          # new profile
        @profile = Profile.new
        @user = current_user
        render :new
      end
    else
      flash[:alert] = "Please login/sign up in order to create a profile"
      redirect_to root_path
    end
  end

def create
  profile = Profile.new(profile_params)
  profile.user = current_user
  profile.linkedin = include_https?(profile)
  if profile.save
    flash[:notice] = "Profile saved successfully"
    # redirect_to profile_path
    redirect_to root_path
  else
    flash[:error] = profile.errors.full_messages.join(", ")
    redirect_to new_profile_path
  end
end

  def edit
    @user = current_user
    render :edit
  end

  def update
    @profile.linkedin = include_https?(@profile)
    if @profile.update_attributes(profile_params)
      flash[:notice] = "Profile updated successfully"
      redirect_to root_path
    else
      flash[:error] = @profile.erorrs.full_messages.join(", ")
      redirect_to edit_profile_path
    end
  end

  def destroy
    if @profile.destroy
      flash[:notice]  = "Profile deleted successfully"
      redirect_to root_path
    else
      flash[:error] = @profile.errors.full_messages.join(", ")
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:country, :state, :city, :occupation, :user_id, :image, :linkedin, :resume)
  end

  def include_https?(profile)
    if profile.linkedin.start_with?("www")
      profile.linkedin = "https://" + profile.linkedin
    else
      profile.linkedin
    end
  end

  def set_profile
    profile_id = params[:id]
    @profile = Profile.find(profile_id)
  end

  def authorize
    if @profile.user_id != current_user.id
      flash[:alert] = "Only record owners can edit and delete records"
      redirect_to root_path
    end
  end

end
