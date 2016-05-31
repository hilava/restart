module ProfilesHelper
  def get_user(id)
    @profile = Profile.find(id)
    if @profile
      @user = User.find(@profile.user_id)
    else
      flash[:alert] = "Profile has not been found"
    end
  end
end
