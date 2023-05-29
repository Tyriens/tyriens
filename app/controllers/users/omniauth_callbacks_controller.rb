class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def discord
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Discord") if is_navigational_format?
    else
      session["devise.discord_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: request.env["omniauth.auth"]
    end
  end

  def failure
    redirect_to root_path
  end
end
