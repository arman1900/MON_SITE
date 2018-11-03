class Api::V1::DoctorsController < ApplicationController
    before_action :correct_user, only: [:update, :destroy]
    def index
        doctors = Doctor.all
        render json: doctor, only: [:username, :id, :email,:hospital_id], include: {hospital: {only: [:location, :id, :name]}}
    end
    
    def show_locked_times
        locked_times = current_doctor.locked_times
        render json: locked_times, only: [:id,:start_time, :end_time, :user_id, :service_id, :accepted]
    end
    def accept_time
        locked_time = LockedTime.find(params[:id])
        if locked_time && locked_time.accepted == false
            locked_time.update_attribute(:accepted,true)
            render json: locked_time, only: [:accepted]
        else
            render json: {error: "There is no such request or you've already accepted it"}, status: :error
        end
    end
    def show
        begin
            doctor = Doctor.find(params[:id])
        rescue
            render json: {errors: "Doctor does not exist"}, status: :error
        ensure
            if doctor
                render json: doctor, only: [:username, :id, :email, :hospital_id], include: {hospital: {only: [:location, :id, :name]}}
            end
        end
    end
    def create
        doctor = Doctor.new(doctor_params)
        puts doctor_params
        if doctor.save
            render json: doctor, only: [:username, :id, :email, :hospital_id], include: {hospital: {only: [:location, :id, :name]}} 
          else
            render json: {errors: doctor.errors.full_messages}, status: :error
          end
    end


    private
    def doctor_params
        params.permit(:username,:email, :password, :password_confirmation,:hospital_id)
    end
    
    def correct_user
        unless signed_in?
            render json: {errors: "Sign in first!"}, status: :error
        else
            @doctor = Doctor.find(params[:id])
            unless current_doctor?(@doctor.id)
                render json: {errors: "You are not allowed to edit others"}, status: :error
            end
        end
    end
end
