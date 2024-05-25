class OmniauthCallbacksController < ApplicationController
  before_action :require_user_logged_in!

  def twitter
    Current.user.twitter_accounts.upsert({
      name: auth.info.name,
      username: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    }, unique_by: :username)

    redirect_to twitter_accounts_path, notice: "Successfully connected your Twitter account"
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
