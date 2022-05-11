class ApplicationController < ActionController::Base

    before_action :current_user
    before_action :logged_in?, :admin?, :user?

    def current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !Current.user.nil?
        # redirect_to sign_in_path, alert: "You must be signed in to do that."
    end

    def admin?
        current_user.role.to_i == 0 if current_user
    end

    def user?
        current_user.role.to_i == 1 if current_user
    end

    def authorized
        redirect_to '/main' unless logged_in?
    end

    def AdminAuthorized
        redirect_to '/main' unless admin?
    end

    
end
