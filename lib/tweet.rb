require 'twitter_oauth'

CLIENT = TwitterOAuth::Client.new(
    :consumer_key    => ENV['TW_CONSUMER_KEY'],
    :consumer_secret => ENV['TW_CONSUMER_SECRET'],
    :token           => ENV['TW_ACCESS_TOKEN'],
    :secret          => ENV['TW_ACCESS_TOKEN_SECRET']
)

raise ArgumentError unless CLIENT.authorized?

def tweet(message)
  raise ArgumentError unless message  
  CLIENT.update message
end
