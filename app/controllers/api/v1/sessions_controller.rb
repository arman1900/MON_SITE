class Api::V1::SessionsController < ApplicationController
    
    def create
        login = session_params[:login]
        if login.include? "@"
            user=User.find_by_email(login) 
        else 
            user=User.find_by_username(login)
        end
    
        if user && user.authenticate(session_params[:password])
            sign_out
            sign_in user
            #remember user
            render json: user, only: [:username, :id, :email], include: {companies: {only: [:name, :id, :creator_id]}}
        else
            render json: {errors: "Invalid username, email or password"}, status: :error
        end
    end
    
    def destroy
        sign_out
        render json: {success: "Successfully signed out"}
    end
    
    def show
        if current_user
            render json: current_user, only: [:username, :id, :email], include: {companies: {only: [:name, :id, :creator_id]}}
        else
            render json: {errors: "Not Signed In"}, status: :error
        end
    end

    private

    def session_params
        params.permit(:login, :password)
    end
    
end
