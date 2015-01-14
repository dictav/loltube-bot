require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['ACCESS_TOKEN']
  config.oauth_token_secret = ENV['ACCESS_TOKEN_SECRET']
  config.auth_method        = :oauth
end

rest_client = Twitter::REST::Client.new do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

# This will pull a sample of all tweets based on
# your Twitter account's Streaming API role.
client = TweetStream::Client.new

client.on_error do |message|
  puts message
end

keywords = %w(
  loltube.tokyo
  loltube_tokyo
)

client.track(*keywords) do |status|
  puts 'retweet'
  rest_client.retweet(status)
end
