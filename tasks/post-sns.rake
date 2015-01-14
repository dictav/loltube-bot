require 'rake'
require 'net/http'
require 'json'

require './lib/tweet.rb'
require './lib/feed_post.rb'

JSON_URL         = ENV['JSON_URL']
MESSAGE_TEMPLATE = ENV['MESSAGE_TEMPLATE']
KEY_PATH         = ENV['VALUE_KEY_PATH']

raise ArgumentError if JSON_URL.nil? or MESSAGE_TEMPLATE.nil? or KEY_PATH.nil?

def extract_value(obj, key_path=KEY_PATH)
  parts = key_path.split '.', 2
  match = obj[parts[0]]
  if !parts[1] or match.nil?
    return match
  else
    return extract_value(match, parts[1])
  end
end

def message
  obj = JSON.parse Net::HTTP.get URI(JSON_URL)
  value = extract_value(obj)
  MESSAGE_TEMPLATE % {value: value}
end

namespace :post do
  desc 'Post message to Twitter'
  task :twitter  do
    puts (tweet message).body
  end

  desc 'Post message to Facebook'
  task :facebook  do
    puts (feed_post message).body
  end
end

