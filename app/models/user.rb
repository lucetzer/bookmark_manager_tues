require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String, required: true

  property :password_digest, Text

    # when assigned the password, we don't store it directly
    # instead, we generate a password digest, that looks like this:
    # "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"
    # and save it in the database. This digest, provided by bcrypt,
    # has both the password hash and the salt. We save it to the
    # database instead of the plain password for security reasons.
    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end

    validates_presence_of :email
    validates_confirmation_of :password
end
