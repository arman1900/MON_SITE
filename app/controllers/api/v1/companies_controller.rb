class Api::V1::CompaniesController < ApplicationController
    before_action :find_company, only: [:destroy, :update, :add_user, :remove_user, :all_posts]
    before_action :find_user, only: [:add_user, :remove_user]

    def create
        unless signed_in?
            render json: {errors: "Please Sign in first"}, status: :error
        else
            company = Company.new(name: params[:name], creator_id: current_user.id)
            if company.save
            current_user.companies << company
            render json: company, only: [:name, :creator_id, :id], include: {users: {only: [:username, :id, :creator_id]}}
            else
            render json: {errors: company.errors.full_messages}, status: :error
            end
        end
    end

    def show
        begin
            @company = Company.find(params[:id])
        rescue
            render json: {errors: "Company does not exist"}, status: :error
        ensure
            if @company
                 render json: @company, only: [:name, :creator_id, :id], include: {users: {only: [:username, :id, :creator_id]}, categories: {only: [:name, :id]}}
            end
        end
    end

    def destroy
        if @company.destroy
            render json: {success: "Deleted Successfully"}
        else
            render json: {errors: @company.errors.full_messages}, status: :error
        end
    end

    def update
        if @company.update_attribute(:name, params[:name])
            render json: @company, only: [:name, :creator_id, :id], include: {users: {only: [:username, :id, :creator_id]}}
        else
            render json: {errors: @company.errors.full_messages}, status: :error
        end
    end

    def add_user
        if @user.companies.where(id: @company.id).count > 0
            render json: {errors: "User is already in Company"}, status: :error
        else
            @user.companies << @company
            render json: {success: "User was added successfully!"}
        end
    end

    def remove_user
        if @user.companies.where(id: @company.id).count == 0
            render json: {errors: "User is not in the Company"}, status: :error
        else
            if @company.creator_id == @user.id
                @company.destroy
                render json: {success: "Company was destroyed"}
            else
                @user.companies.delete(@company)
                render json: {success: "User was removed successfully!"}
            end
        end
    end
    
    def all_posts
        render json: @company.categories.map{ |x| x.posts}
    end
    private
    
    def find_company
        begin
            @company = Company.find(params[:id])
        rescue
            render json: {errors: "Company does not exist"}, status: :error
        ensure
            if !signed_in?
                render json: {errors: "Please Sign in first"}, status: :error
            elsif  !(current_user.id == @company.creator_id)
                render json: {errors: "You cannot change other Companies"}, status: :error
            end
        end
    end

    def find_user
        login = params[:login]
        if login.include? "@"
            @user=User.find_by_email(login) 
        else 
            @user=User.find_by_username(login)
        end
        unless @user
            render json: {errors: "User is not found"}, status: :error
        end
    end
end
