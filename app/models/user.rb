class User < ApplicationRecord
    has_secure_password
    
    has_many :locked_times, dependent: :destroy


    attr_accessor :remember_token
    before_save {self.email = email.downcase
        self.username = username.camelize}
    validates_presence_of :email, :username, :Iin
    validates_uniqueness_of :email, :username, :Iin
    validates_email_format_of :email, message: 'The email format is not correct!'
    validates :password, length: {minimum: 6, maximum: 30}, allow_nil: true
    validates :username, length: {maximum: 100}
      def update_with_password(params, *options)
        if encrypted_password.blank?
          update_attributes(params, *options)
        else
          super
        end
      end
    
    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end

    end
    def send_password_reset_email
        new_password=SecureRandom.urlsafe_base64
        self.update_attribute(:password, new_password)
        UserMailer.password_reset(self,new_password).deliver_now
    end
    def remember
        @remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

end
