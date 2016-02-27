class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         otp_secret_encryption_key: ENV['DEVISE_TWO_FACTOR_ENCRYPTION_KEY']

  self.otp_secret_length = 16
end
