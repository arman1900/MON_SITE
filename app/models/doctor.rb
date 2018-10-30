class Doctor < ApplicationRecord
    has_secure_password
    attr_accessor :remember_token
    before_save {self.email = email.downcase
        self.username = username.camelize}
        validates_presence_of :email, :username
        validates_uniqueness_of :email, :username
        validates_email_format_of :email, message: 'The email format is not correct!'
        validates :password, length: {minimum: 6, maximum: 30}, allow_nil: true
        validates :username, length: {maximum: 100}
end
