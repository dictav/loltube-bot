require 'rake'
require 'json'

require './lib/azure.rb'

def make_front_json
  json = JSON.parse File.read('./playlist_stocks.json')
  featured, *newest  = json.sample(20)
  {
    featured: featured,
    newest: newest,
    picked: []
  }.to_json
end

namespace :upload do
  desc 'Upload front.json to Azure'
  task :azure  do
    blob = azure('json', 'front.json', make_front_json)
    raise "ERROR: Could not upload front.json" unless blob
    prop = blob.properties
    puts "uploaded: {etag: #{prop[:etag]},md5: #{prop[:content_md5]}}"
  end
end
