# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def account_activation
        def account_activation
            UserMailer.account_activation
          end
          end
          def password_reset
            UserMailer.password_reset
              end
end
