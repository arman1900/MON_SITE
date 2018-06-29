class UsersController < ApplicationController
    def new 
        @user= User.new
    end
    def show
        @user = User.find(params[:id])
    end
    def create
        redirect_to root_path if signed_in?
        @user = User.new(user_params)
                if @user.save
                    UserMailer.account_activation(@user).deliver_now
                    sign_in @user
                redirect_to @user
                flash[:success] = "Signed up successfully"
        		else
        			render :new
        		end
    end
    def edit
        @user=User.find(params[:id])
    end
    def update
        @user= User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Changes were successfully saved"
             redirect_to @user
        else
            render 'edit'
        end
    end
    private
	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    def correct_user
        unless signed_in?
            flash[:danger] = "Please sign in first"
            redirect_to login_url
        else
            @user = User.find(params[:id])
            unless current_user?(@user)
                flash[:danger] = "You are not allowed to edit others"
                redirect_to user_path 
            end
        end
    end
end
