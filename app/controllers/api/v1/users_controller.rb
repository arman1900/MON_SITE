class Api::V1::UsersController < ApplicationController
    before_action :check_token
    skip_before_action :verify_authenticity_token

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

    private
    def user_params
		params.permit(:username, :email, :password, :password_confirmation)
    end
    
    def check_token
        unless Developer.find_by(token: params[:token])
            render json: {errors: "Incorrect Token"}, status: :error
        end
    end
end
