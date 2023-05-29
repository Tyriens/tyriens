class ProfilesController < ApplicationController
  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to edit_profile_path
    else
      redirect_to edit_profile_path
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  private

  def profile_params
    params.require(:user).permit(:twitch_url, :youtube_url)
  end
end
