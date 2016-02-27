class AddOtpRequiredForLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :otp_required_for_login, :boolean
  end
end
