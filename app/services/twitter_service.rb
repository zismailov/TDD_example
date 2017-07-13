class TwitterService
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = " you_key "
      config.consumer_secret = " you_secret "
      config.access_token = " you_token "
      config.access_token_secret = " you_token_secret "
    end
  end

  def tweet(message)
    @client.update(message)
  end
end
