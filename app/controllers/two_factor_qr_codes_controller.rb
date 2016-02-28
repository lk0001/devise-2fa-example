class TwoFactorQrCodesController < ApplicationController
  def show
    respond_to do |format|
      format.svg do
        render qrcode: current_user.provisioning_uri, unit: 6
      end
    end
  end
end
