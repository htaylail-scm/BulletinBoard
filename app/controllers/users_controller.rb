class UsersController < ApplicationController


    # skip_before_action :authorized, only: [:new, :create]
    # skip_before_action :AdminAuthorized, except: [:destroy, :index]

    def index
        search
        # @search = User.new(params[:search])       
    end

    # def index
    #     @search_params = search_params
    #     @users = User.search(search_params)
    # end
  

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
        @user = User.new(user_update_params)
        unless @user.valid?
            render :edit
        end
      end
    
      def update
        @user = User.find(params[:id])
        if @user.update(user_update_params)
          redirect_to @user
        else
          render :edit
        end
      end
    
  
    def destroy
        @user = User. find(params[:id])
        @user.destroy
        redirect_to users_path, notice: "User delete Successfully."
    end   


    def search
        if params[:search]
            @users = User.where(["email LIKE ? OR name LIKE ? ","%#{params[:search]}%","%#{params[:search]}%"])
        else
            @users = User.all
        end
    end

    # def search
    #     @name = search_params[:name]
    #     @email = search_params[:email]
    #     @from_date = search_params[:from_date]
    #     @to_date = search_params[:to_date]
    #     if @from_date.present? and @to_date.present?
    #         users = Userwhere("name like ? and email like ? and created_at >= ? and created_at <= ?", "%" + name + "%", "%" + email + "%", from_date, Date.parse(to_date)+1)
    #     elsif @from_date.present?
    #         users = User.where("name like ? and email like ? and created_at >= ?", "%" + name + "%", "%" + email + "%", from_date)
    #     elsif @to_date.present?
    #         users = User.where("name like ? and email like ? and created_at <= ?", "%" + name + "%", "%" + email + "%", Date.parse(to_date)+1)
    #     else
    #         users = User.where("name like ? and email like ?", "%" + name + "%", "%" + email + "%")
    #     end
    # end

   


    private
    def user_params
        # params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :photo)
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :photo, :created_user_id, :updated_user_id)
    end

    def user_update_params
        params.require(:user).permit(:name, :email, :role, :phone, :dob, :address, :photo)
    end

    def search_params
        params.permit(:name, :email, :from_date, :to_date)
    end



end