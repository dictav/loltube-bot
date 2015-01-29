require 'net/http'
require 'uri'
FB_PAGE_ID    = ENV['FB_PAGE_ID']
FB_PAGE_TOKEN = ENV['FB_PAGE_TOKEN']

raise ArgumentError if FB_PAGE_ID.nil? or FB_PAGE_TOKEN.nil?

def feed_post(message)
  raise ArgumentError unless message
  link = URI.extract(message)
  url = URI("https://graph.facebook.com/v2.2/#{FB_PAGE_ID}/feed")
  Net::HTTP.post_form url, {access_token: FB_PAGE_TOKEN, message: message, link: link}
end
