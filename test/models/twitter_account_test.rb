require "test_helper"

class TwitterAccountTest < ActiveSupport::TestCase
  test "requires username" do
    user = User.new(email: "user@example.org", password: "a1b2c3")
    assert user.valid?

    twitter_account = TwitterAccount.new(user: user)
    assert_not twitter_account.valid?

    assert_includes twitter_account.errors.messages[:username], "can't be blank"
  end
end
