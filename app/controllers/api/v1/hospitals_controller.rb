class Api::V1::HospitalsController < ApplicationController

    def index
        hospital = Hospital.all
        render json: hospital, only: [:location, :name, :id]
    end

    def create
        hospital = Hospital.new(hospital_params)
        puts hospital_params
        if hospital.save
            render json: hospital, only: [:name, :location, :id] 
          else
            render json: {errors: hospital.errors.full_messages}, status: :error
          end
    end

    def show
        begin
            hospital = Hospital.find(params[:id])
        rescue
            render json: {errors: "Hospital does not exist"}, status: :error
        ensure
            if hospital
                render json: hospital, only: [:name, :id, :location], include: {doctors: {only: [:id, :username, :email]}}
            end
        end
    end
    private
    def hospital_params
        params.permit(:location,:name)
    end
end