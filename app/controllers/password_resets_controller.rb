class PasswordResetsController < ApplicationController
    def new 
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
            # send email
            PasswordMailer.with(user: @user).reset.deliver_now
            redirect_to root_path, notice: "Send link for reset password."
        else
            redirect_to password_reset_path, notice: "Cannot found this email."
        end
    end

    def edit
        # @user = User.find_signed(params[:token], purpose: "password_reset")
        @user = User.find_signed!(params[:token], purpose: "password_reset")
        rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to user_login_path, alert: "Your token has expired. Please try again."
    end

    def update
        @user = User.find_signed(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to user_login_path, notice: "Your password was reset successfully. Plese sing in."   
        else
            render editReset
        end
    end

    private

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
    
end
