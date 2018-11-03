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
                render json: service, only: [:id, :name], include: { hospitals: {only: [:name, :location]}}
            end
        end
    end
end
