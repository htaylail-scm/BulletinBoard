class SessionsController < ApplicationController

  # skip_before_action :authorized, only: [:new, :create, :welcome]
  # skip_before_action :AdminAuthorized, except: [:page_requires_login]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      if user && user.authenticate(params[:password])
        if params[:remember_me]
          session[:user_id] = { value: user.id, expires: 2.weeks.from_now }
        else
          session[:user_id] = user.id
        end
        redirect_to root_path, notice: "Logged in succefully"
    else
        flash[:alert] = "Passwrod is wrong!"
        render :new
      end
    else
      flash[:alert] = "Email is wrong!"
      render :new
    end
  end


  def destory
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end
end