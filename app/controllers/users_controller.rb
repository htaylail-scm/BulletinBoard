class UsersController < ApplicationController


    # skip_before_action :authorized, only: [:new, :create]
    # skip_before_action :AdminAuthorized, except: [:destroy, :index]

    def index
       search
    end


    def show 
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def confirm_create
        @user = User.new(user_params)
    end

    def create
        @user = User.new(user_params)
        # @user.role ||= 1 ;
        if current_user.present?
            @user.created_user_id = current_user.id
            @user.updated_user_id = current_user.id
        else
            @user.created_user_id = 1
            @user.updated_user_id = 1
        end
        if @user.save
            session[:user_id] = @user.id
            redirect_to users_path, notice: "Successfully created account."       
        else
            render :new
        end      
    end

    def edit
        @user = User.find(params[:id])
    end

    def confirm_update
        @user = User.find(params[:id])
        @user.name = user_update_params[:name]
        @user.email = user_update_params[:email]
        @user.role = user_update_params[:role]
        @user.phone = user_update_params[:phone]
        @user.dob = user_update_params[:dob]
        @user.address = user_update_params[:address]
        @user.photo = user_update_params[:photo]
        if !@user.valid?
            render :edit
        end
    end

    def update
        @user = User.find(params[:id])
        @user.updated_user_id = current_user.id
        if @user.update(user_update_params)
            redirect_to users_path, notice: "User data Updated"
        else
            render :edit
        end
    end
  
    def destroy
        @user = User.find(params[:id])
        @user.update(
            'deleted_at' => Time.now,
            'deleted_user_id' => current_user.id
        )
        @user.destroy
        redirect_to users_path, notice: "User delete Successfully."
    end   

    def search 
        from_date = params[:from_date]   
        to_date = params[:to_date]  
        name = params[:name]  
        email = params[:email]     
        if from_date.present? and to_date.present?
            @users = User.where("name like ? and email like ? and created_at >= ? and created_at <= ?", "%" + name + "%", "%" + email + "%", from_date, Date.parse(to_date)+1).paginate(page: params[:page], per_page: 3)
        elsif from_date.present?
            @users = User.where("name like ? and email like ? and created_at >= ?", "%" + name + "%", "%" + email + "%", from_date).paginate(page: params[:page], per_page: 3)
        elsif to_date.present?
            @users = User.where("name like ? and email like ? and created_at <= ?", "%" + name + "%", "%" + email + "%", Date.parse(to_date)+1).paginate(page: params[:page], per_page: 3)
        elsif name .present?
            @users = User.where("name like ? and email like ?", "%" + name + "%", "%" + email + "%").paginate(page: params[:page], per_page: 3)
        else
            @users = User.paginate(page: params[:page], per_page: 3)
        end
    end


    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :photo, :created_user_id, :updated_user_id)
    end

    def user_update_params
        params.require(:user).permit(:name, :email, :role, :phone, :dob, :address, :photo)
    end

    def search_params
        params.permit(:name, :email, :from_date, :to_date)
    end

end