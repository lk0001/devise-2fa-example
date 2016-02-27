class TwoFactorQrCodesController < ApplicationController
  def show
    respond_to do |format|
      format.svg do
        render qrcode: current_user.otp_provisioning_uri(current_user.email), unit: 6
      end
    end
  end
end
