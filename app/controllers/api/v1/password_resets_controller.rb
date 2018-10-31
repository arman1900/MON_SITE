class Api::V1::PasswordResetsController < ApplicationController
  before_action :get_valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.send_password_reset_email
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end
  def doctor_create
    @doctor = Doctor.find_by(email: params[:email].downcase)
    if @doctor
      @doctor.send_password_reset_email
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  private

  def check_user
  end
end