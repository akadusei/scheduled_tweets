class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: 1..280
  validates :publish_at, presence: true

  after_initialize { self.publish_at = 24.hours.from_now }

  after_save_commit do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def published?
    tweet_id?
  end

  def publish_to_twitter!
    return if published?
    return if publish_at > Time.current

    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end
end
