class DoctorMailer < ApplicationMailer
    def account_activation(doctor)
        @doctor = doctor
        mail to: doctor.email, subject: "Account activation"
      end
    def password_reset(doctor, new_password)
        @new_password = new_password
        mail to: doctor.email, subject: "Password reset"
    end
end
