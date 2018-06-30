class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable
    has_secure_password 
    has_and_belongs_to_many :companies, class_name: "Company"
    has_many :posts, dependent: :destroy

    attr_accessor :remember_token
    before_save {self.email = email.downcase
        self.username = username.downcase}

    validates_presence_of :email, :username
    validates_uniqueness_of :email, :username
    validates_email_format_of :email, message: 'The email format is not correct!'
    validates :password, length: {minimum: 6, maximum: 30}, allow_nil: true
    validates :username, format: { with: /\A[0-9a-zA-Z_.\-]+\Z/, message: "Only alphanumeric characters, and -_."}
    validates :username, length: {maximum: 30}
    def self.from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_create do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.username = auth.info.nickname
        end
    end
    def self.new_with_session(params, session)
        if session["devise.user_attributes"]
          new(session["devise.user_attributes"], without_protection: true) do |user|
            user.attributes = params
            user.valid?
          end
        else
          super
        end
      end
      def password_required?
        super && provider.blank?
      end
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
