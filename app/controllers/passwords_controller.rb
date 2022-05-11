class PasswordsController < ApplicationController
    before_action :require_user_logged_in!
    
    # skip_before_action :authorized, only: [:new, :create, :edit, :editReset, :updateReset]
    # skip_before_action :AdminAuthorized, except: []

    
    def update
        if Current.user.authenticate(password_params[:old_password])
            if Current.user.update(password_params)
                redirect_to root_path, notice: "Password updated!"
            else
                flash[:alert] = "something wrong"
                render :edit
            end
        else
           flash[:alert] = "Old password is not correct."
           render :edit
        end
    end



    def update
        if Current.user.update(password_params)
            redirect_to root_path, notice: "Password updated!"
        else
            render :edit
        end
    end
    

    private
     def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
        
    # def password_params
    #     params.permit(:old_password, :password, :password_confirmation)
    # end
    # def reset_password_params
    #     params.require(:user).permit(:password, :password_confirmation)
    # end
end