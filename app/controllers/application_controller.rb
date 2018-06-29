class ApplicationController < ActionController::Base
    before_action :check_token
    skip_before_action :verify_authenticity_token
    include Api::V1::SessionsHelper

    private
    def check_token
        unless Developer.find_by(token: params[:token])
            render json: {errors: "Incorrect Token"}, status: :error
        end
    end
end
