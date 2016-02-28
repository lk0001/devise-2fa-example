class TwoFactorSettingsController < ApplicationController
  def edit
    unless current_user.otp_required_for_login?
      current_user.populate_otp_column
      current_user.save!
    end
    render :edit, locals: {two_factor_secret: current_user.otp_secret_key}
  end

  def update
    if current_user.otp_required_for_login?
      disable_2fa
    else
      enable_2fa
    end
  end

  private

  def enable_2fa
    if params[:verification_code].present? && current_user.authenticate_otp(params[:verification_code])
      current_user.update!(otp_required_for_login: true)
      redirect_to root_path, notice: 'Two-factor authentication enabled!'
    else
      flash[:alert] = 'Verification code is invalid!'
      render :edit, locals: {two_factor_secret: current_user.otp_secret_key}
    end
  end

  def disable_2fa
    if current_user.valid_password?(params[:password])
      current_user.update!(otp_required_for_login: false)
      redirect_to root_path, notice: 'Two-factor authentication disabled!'
    else
      flash[:alert] = 'Incorrect password.'
      render :edit
    end
  end
end
