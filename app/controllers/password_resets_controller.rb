class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user.present?
      PasswordMailer.with(user: user).reset.deliver_now
    end

    redirect_to root_path, notice: "Check your email for a link to reset your password"
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: :password_reset)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to password_reset_path, alert: "Invalid token. Please try again"
  end

  def update
    @user = User.find_signed!(params[:token], purpose: :password_reset)

    if @user.update(password_params)
      redirect_to sign_in_path, notice: "You have successfully reset your password"
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
