class PasswordsController < ApplicationController
  before_action :logged_in?
  
  # skip_before_action :authorized, only: [:new, :create, :edit, :editReset, :updateReset]
  # skip_before_action :AdminAuthorized, except: []  

  
  def update
    if current_user.authenticate(password_change_params[:old_password])
      if current_user.update(password_change_params)
        redirect_to root_path, notice: "Your password has been changed."
      else
        redirect_to edit_password_path, notice: "New password and confirm password must be same. "
      end
    else
      redirect_to edit_password_path, notice: "Your old password is wrong!"
    end
  end
    

  private
  def password_change_params
    params.require(:user).permit(:old_password, :password, :password_confirmation)
  end
  
end