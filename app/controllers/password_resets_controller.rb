class PasswordResetsController < ApplicationController
    def new 
    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            # send email
            PasswordMailer.with(user: @user).reset.deliver_now
        end
        # redirect_to root_path, notice: "Account not found with this email"
        redirect_to root_path, notice: "If an account with that email was found , we have sent a linkto reset your password."
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to user_login_path, alert: "Your token has expired. Please try again."
    end

    def update
        
    end



end
