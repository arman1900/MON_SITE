class Api::V1::UsersController < ApplicationController
    before_action :correct_user, only: [:update, :destroy, :show_locked_times, :destroy_locked_time]
    before_action :correct_time, only: [:create_locked_time_all]
    before_action :correct_time, only: [:create_locked_time_doctor]
    
    def index
        users = User.all
        render json: users, only: [:username, :id, :email, :Iin]
    end

    def show_locked_times
        locked_times = @user.locked_times
        render json: locked_times, only: [:id,:start_time, :end_time, :user_id, :service_id, :accepted]
    end

    def destroy_locked_time
        user = current_user
        locked_time = LockedTime.find(params[:id])
        if user && locked_time && locked_time.user_id == user.id
            locked_time.destroy! 
        else
            render json: {errors: "User is not signed in or Locked time do not exist or User is not allowed to delete this locked time"}, status: :error
        end
    end

    def create_locked_time_all
        user = current_user
        if user
            hospital = Hospital.find(params[:hospital_id])
            begin
                service = Service.find(params[:service_id])
            rescue
                render json: {errors: "There is no such service"}, status: :error
            end
            ltime_errors = []
            hospital.doctors.each do |doctor|
                if(doctor.is_serves(service))
                    cur_params = {
                        start_time: @start_time,
                        end_time: @end_time,
                        service_id: params[:service_id],
                        doctor_id: doctor.id,
                        user_id: user.id,
                        hospital_id: params[:hospital_id]
                    }
                    ltime = LockedTime.new(cur_params)
                    unless ltime.save
                        ltime_errors.append(ltime.errors.full_messages)
                    end
                end
            end
            render json: {errors: ltime_errors}, status: :error
        else
            render json: {errors: "User is not signed in"}, status: :error
        end
    end

    def create_locked_time_doctor
        doctor = Doctor.find(params[:doctor_id])
        begin
            service = Service.find(params[:service_id])
        rescue
            render json: {errors: "There is no such service"}, status: :error
        end
        if(doctor.is_serves(service))
            cur_params = {
                start_time: @start_time,
                end_time: @end_time,
                service_id: params[:service_id],
                doctor_id: doctor.id,
                user_id: current_user.id,
                hospital_id: doctor.hospital.id
            }
            ltime = LockedTime.new(cur_params)
            unless ltime.save
                render json: {errors: ltime.errors.full_messages}, status: :error
            else
                render json: ltime, status: :success
            end
        else
            render json: {error: "Something is wrong!"}, status: :error
        end
    end


    def show
        begin
            user = User.find(params[:id])
        rescue
            render json: {errors: "User does not exist"}, status: :error
        ensure
            if user
                render json: user, only: [:username, :id, :email, :Iin]
            end
        end
    end

    def create
        user = User.new(user_params)
        puts user_params
        if user.save
            render json: user, only: [:username, :id, :email, :Iin] 
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
                render json: user, only: [:username, :id, :email, :Iin]
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
            Company.where(created_id: user.id).destroy_all
            sign_out

            if user.destroy!
                render json: {success: "Deleted Successfully"}
            else
                render json: {errors: user.errors.full_messages}, status: :error
            end
        end
    end

    private

    def correct_time
        unless signed_in?
            render json: {errors: "Sign in first!"}, status: :error
        else
            @start_time = DateTime.parse(params[:start_time])
            @end_time = DateTime.parse(params[:end_time])
            if @start_time > @end_time
                render json: {errors: "Endtime more than starttime"}, status: :error
            end
            locked_times = current_user.locked_times
            locked_times.each do |l|
                if l.end_time < @start_time && l.start_time > @end_time
                    next
                else
                    render json: {errors: "You already have this time"}, status: :error
                end    
            end
        end 
    end
    def user_params
        params.permit(:username,:Iin,:email, :password,:password_confirmation)
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