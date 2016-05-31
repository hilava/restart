class ProfilesController < ApplicationController
  def index

    if params[:search]
      # call search method in model.rb
      @profiles = Profile.search(params[:search]).order("created_at DESC")
    else
      @profiles = Profile.all.order('created_at DESC')
    end
    render :index
  end

  def show
    @profile = Profile.find_by(user_id: params[:id])
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
      flash[:notice] = "Please login/sign up in order to create a profile"
      redirect_to root_path
    end
  end

def create
  profile = Profile.new(profile_params)
  profile.user = current_user
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
    @profile = Profile.find(params[:id])
    @user = current_user
    render :edit
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      flash[:notice] = "Profile updated successfully"
      redirect_to root_path
    else
      flash[:error] = @profile.erorrs.full_messages.join(", ")
      redirect_to edit_profile_path
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
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
end
