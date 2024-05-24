class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def require_user_logged_in!
    return if Current.user.present?
    redirect_to sign_in_path, alert: "You must be signed in to do that"
  end
end
