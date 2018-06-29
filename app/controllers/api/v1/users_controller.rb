class Api::V1::UsersController < ApplicationController
    before_action :correct_user, only: [:update, :destroy]
    

    def index
        users = User.all
        render json: users, only: [:username, :id, :email]
    end

    def show
        begin
            user = User.find(params[:id])
        rescue
            render json: {errors: "User does not exist"}, status: :error
        ensure
            if user
                render json: user, only: [:username, :id, :email], include: {companies: {only: [:name, :id, :creator_id]}}
            end
        end
    end

    def create
        user = User.new(user_params)
        puts user_params
        if user.save
            render json: user, only: [:username, :id, :email] 
          else
            render json: {errors: user.errors.full_messages}, status: :error
          end
    end

    def update
        begin
            user = User.find(params[:id])
        rescue
            render json: {errors: "User does not exist"}, status: :error
        ensure
            if user.update_attributes(user_params)
                render json: user, only: [:username, :id, :email], include: {companies: {only: [:name, :id, :creator_id]}}
            else
                render json: {errors: user.errors.full_messages}, status: :error
            end
        end
    end

    def destroy
        begin
            user = User.find(params[:id])
        rescue
            render json: {errors: "User does not exist"}, status: :error
        ensure
            sign_out
            if user.destroy!
                render json: {success: "Deleted Successfully"}
            else
                render json: {errors: user.errors.full_messages}, status: :error
            end
        end
    end

    private
    def user_params
		params.permit(:username, :email, :password, :password_confirmation)
    end
    
    def correct_user
        unless signed_in?
            render json: {errors: "Sign in first!"}, status: :error
        else
            @user = User.find(params[:id])
            unless current_user?(@user.id)
                render json: {errors: "You are not allowed to edit others"}, status: :error
            end
        end
    end
    
end
