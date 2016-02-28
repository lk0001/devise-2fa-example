class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :two_factor_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one_time_password(encrypted: true)

  def need_two_factor_authentication?(request)
    otp_required_for_login?
  end

  def send_two_factor_authentication_code
    # use Model#otp_code and send via SMS, etc.
  end
end
