require 'azure'
require 'zlib'
require 'stringio'

ACCOUNT_NAME = ENV['AZURE_STORAGE_ACCOUNT']
ACCESS_KEY   = ENV['AZURE_STORAGE_ACCESS_KEY']

raise ArgumentError if ACCESS_KEY.nil? or ACCESS_KEY.nil?

Azure.configure do |conf|
  conf.storage_account_name = ACCOUNT_NAME
  conf.storage_access_key = ACCESS_KEY
end


def azure(container, filename, content)
  raise ArgumentError unless container and content

  blob = Azure::BlobService.new
  blob.create_block_blob(
    container,
    filename,
    content,
    {
      content_type:     'application/json; charset=utf-8',
      cache_control:    'public, max-age=86400' #1day
    }
  )
end
