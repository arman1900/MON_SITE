class Api::V1::CompaniesController < ApplicationController
    def create
        company = Company.new("company_params")
        if company.save
          current_user.companies << @company
          render json: company, only: [:name, :creator_id], include: {users: {only: [:username, :id, :creator_id]}}
        else
          #render
        end
      end
end
