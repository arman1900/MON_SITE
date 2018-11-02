class Api::V1::ServicesController < ApplicationController
    def index
        services = Service.all
        render json: services, only: [:id, :name]
    end

    def show
        begin
            service = Service.find(params[:id])
        rescue
            render json: {errors: "Service does not exist!"}, status: :error
        ensure
            if service
                hospital_ids = []
                service.doctors.each do |doctor|
                    hospital_ids.append(doctor.hospital_id)
                    
                end
                hospital_ids = hospital_ids.uniq
                hospitals = Hospital.find(hospital_ids)
                ser_hash = {service: { id: service.id, name: service.name, hospitals: hospitals}}
                render json: ser_hash
            end
        end
    end
end
