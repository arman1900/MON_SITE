module Api::V1::SessionsHelper


    def delete_past_time(user_doctor)
        user_doctor.locked_times.each do |ltime|
            if ltime.end_time < DateTime.now
                ltime.destroy!
            end
        end
    end
    
    def sign_in(user)
        session[:user_id] = user.id
        delete_past_time(user)
    end
    
    def doctor_sign_in(doctor)
        session[:doctor_id] = doctor.id
        delete_past_time(doctor)
    end
    
    def signed_in?
        !current_user.nil?
    end
    
    def doctor_signed_in?
        !current_doctor.nil?
    end
    
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
    
    def doctor_remember(doctor)
        doctor.remember
        cookies.permanent.signed[:doctor_id] = doctor.id
        cookies.permanent[:remember_token] = doctor.remember_token
    end
    
    def current_user?(user_id)
        current_user.id == user_id if current_user
    end
    
    def current_doctor?(doctor_id)
        current_doctor.id == doctor_id if current_doctor
    end
    
    def current_user
        if user_id = session[:user_id]
            @current_user ||= User.find(user_id)
        elsif user_id = cookies.signed[:user_id]
            user = User.find(user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                sign_in user
                @current_user = user
            end
        else 
            @current_user
        end
    end
    
    def current_doctor
        if doctor_id = session[:doctor_id]
            @current_doctor ||= Doctor.find(doctor_id)
        elsif doctor_id = cookies.signed[:doctor_id]
            doctor = Doctor.find(doctor_id)
            if doctor && doctor.authenticated?(:remember, cookies[:remember_token])
                doctor_sign_in doctor
                @current_doctor = doctor
            end
        else 
            @current_doctor
        end
    end

    def forget (user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    def doctor_forget (doctor)
        doctor.forget
        cookies.delete(:doctor_id)
        cookies.delete(:remember_token)
    end
    
    def sign_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    def doctor_sign_out
        doctor_forget(current_doctor)
        session.delete(:doctor_id)
        @current_doctor = nil
    end
    
end
