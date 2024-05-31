class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    tweet.publish_to_twitter!
  end
end
