class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.update_attribute(:activated, true)
            user.update_attribute(:activated_at, Time.zone.now)
            sign_in user
            flash[:succes] = "Account activated!"
            redirect_to root_path
        else
            flash[:danger] = "Invalid activation link"
            redirect_to root_path
        end
    end
end
