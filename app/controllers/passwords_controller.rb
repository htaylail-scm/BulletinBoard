class PasswordsController < ApplicationController
    before_action :logged_in?
    
    # skip_before_action :authorized, only: [:new, :create, :edit, :editReset, :updateReset]
    # skip_before_action :AdminAuthorized, except: []


    # def update
    #     if current_user.authenticate(password_params[:old_password])
    #         if current_user.update(password_params)
    #             redirect_to root_path, notice: "Your password has been changed."
    #         else
    #             redirect_to edit_password_path, notice: "Something went wrong."
    #         end
    #     else
    #         redirect_to edit_password_path, notice: "Your old password is wrong!"
    #     end
    # end

    
   
    
    # def update
    #     # current_user.id = User.find(params[:id])
    #     old_password = params[:user][:old_password]
    #     user = User.authenticate(current_user.email, old_password)
    #     if @user && user
    #       # @user.update.password = params[:new_password]
    #       # new_password = params[:password]
    #       # @user.update(new_password)
    #       user.update_attribute(password: params[:user][:old_password])
    #       flash[:success] = "Password successfully changed!"
    #       redirect_to user_path(@current_user)
    #     else
    #       flash[:danger] = "Your old password was incorrect. Please try again."
    #       redirect_to user_path(@current_user)
    #     end
    # end

    # def update
    #     # current_user.id = User.find(params[:id])
    #     current_password = params[:user][:current_password]
    #     user = User.authenticate(@user.email, current_password)
    #     if @user && user
    #       # @user.update.password = params[:new_password]
    #       # new_password = params[:password]
    #       # @user.update(new_password)
    #       user.update_attribute(password: params[:user][:current_password])
    #       flash[:success] = "Password successfully changed!"
    #       redirect_to user_path(@current_user)
    #     else
    #       flash[:danger] = "Your old password was incorrect. Please try again."
    #       redirect_to user_path(@current_user)
    #     end
    # end


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
    
   
    # private  
    # def password_params
    #     params.permit(:old_password, :password, :password_confirmation)
    # end
    
end