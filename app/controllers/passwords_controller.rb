class PasswordsController < ApplicationController
    before_action :require_user_logged_in!

    
#     def update
#         if Current.user.authenticate(params[:old_password])
#             if Current.user.update(password_params)
#                 redirect_to root_path, notice: "Password updated!"
#             else
#                 flash[:alert] = "New password and confirmation password are not same"
#                 render :edit
#             end
#         else
#            flash[:alert] = "Current password is not correct."
#            render :edit
#         end
#     end

#     private
#      def password_params
#         params.require(:user).permit(:old_password, :password, :password_confirmation)
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
end