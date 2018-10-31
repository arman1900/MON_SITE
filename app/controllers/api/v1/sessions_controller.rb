class Api::V1::SessionsController < ApplicationController
    
    def create
        login = session_params[:login]
            user=User.find_by_email(login)
        if user && user.authenticate(session_params[:password])
            sign_in user
            #remember user
            render json: user, only: [:username, :id, :email, :Iin] 
        else
            render json: {errors: "Invalid username, email or password"}, status: :error
        end
    end
    def doctor_create
        login = session_params[:login]
            doctor=Doctor.find_by_email(login)
        if doctor && doctor.authenticate(session_params[:password])
            doctor_sign_in doctor
            #remember user
            render json: doctor, only: [:username, :id, :email, :hospital_id], include: {hospital: {only: [:location, :id, :name]}} 
        else
            render json: {errors: "Invalid username, email or password"}, status: :error
        end
    end
    def destroy
        sign_out
        render json: {success: "Successfully signed out"}
    end
    def doctor_destroy
        doctor_sign_out
        render json: {success: "Successfully signed out"}
    end
    
    def show
        if current_user
            render json: current_user, only: [:username, :id, :email, :Iin]
        else
            render json: {errors: "Not Signed In"}, status: :error
        end
    end
    def doctor_show
        if current_doctor
            render json: current_doctor, only: [:username, :id, :email, :hospital_id], include: {hospital: {only: [:location, :id, :name]}} 
        else
            render json: {errors: "Not Signed In"}, status: :error
        end
    end
    private

    def session_params
        params.permit(:login, :password)
    end
    
end
