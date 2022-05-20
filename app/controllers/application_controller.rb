class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :logged_in?, :admin?, :user?
  
  def current_user
    if session[:user_id]
      current_user = User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    current_user.role.to_i == 0 if current_user
  end

  def user?
    current_user.role.to_i == 1 if current_user
  end

  def authorized
    unless logged_in?
      redirect_to '/', :alert => "You don't have permission!"
    end
  end

  def check_admin
    unless current_user.role.to_i == 0
      redirect_to '/', :alert => "Don't have permission!"
    end
  end
    
end