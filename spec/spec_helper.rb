$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'service_now'
require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/cassettes'
  c.before_record do |i|
    i.response.body.force_encoding 'UTF-8'
  end
end
