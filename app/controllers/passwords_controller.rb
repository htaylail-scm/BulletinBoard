class PasswordsController < ApplicationController
    before_action :require_user_logged_in!

    def edit
    end

    def update
        if Current.user.update(passwword_params)
            redirect_to root_path, notice: "Password updated!"
        else
            render :new
        end
    end

    private
     def passwword_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end