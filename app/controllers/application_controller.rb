class ApplicationController < ActionController::Base

    # before_action :current_user
    # before_action :logged_in?, :admin?, :user?
    
    # before_action :authorized
    # before_action :AdminAuthorized
    helper_method :current_user
    helper_method :logged_in?, :admin?, :user?

    def current_user
      if session[:user_id]
        current_user = User.find_by(id: session[:user_id])
      end
    end

    def logged_in?
      !current_user.nil?
      # if current_user.nil?
      #     redirect_to root_path
      # end
       
    end

    def admin?
      current_user.role.to_i == 0 if current_user
    end

    def user?
      current_user.role.to_i == 1 if current_user
    end

    def authorized
      redirect_to root_path  unless logged_in?
    end

    def AdminAuthorized
      redirect_to root_path unless admin?
    end
    
end