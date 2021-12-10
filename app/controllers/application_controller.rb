class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  # before_action :authenticate_user!ユーザがログインしているかどうかを確認、ログインしていない場合はユーザをログインページにリダイレクト
	before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
