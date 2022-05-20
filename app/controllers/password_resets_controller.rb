class PasswordResetsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :edit, :update]
  skip_before_action :check_admin, except: []

  def new 
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      # send email
      PasswordMailer.with(user: @user).reset.deliver_now
      redirect_to root_path, notice: "We send reset password link. Please check your email."
    else
      redirect_to password_reset_path, notice: "Cannot found this email."
    end
  end


  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to user_login_path, alert: "Your token has expired. Please try again."
  end
  

  def update
    @user = User.find_signed(params[:token], purpose: "password_reset")
    if @user.update(reset_password_params)
      redirect_to user_login_path, notice: "Your password was reset successfully. Plese Sigin."   
    else
      redirect_to password_reset_edit_path(token: params[:token]), notice: "New password and confirm password are not same"
    end
  end

  private

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
end
