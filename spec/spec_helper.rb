# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'service_now'
require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/cassettes'
  c.filter_sensitive_data('<SN_HOST>') { ENV['SN_HOST'] }
  c.filter_sensitive_data('<SN_USER>') { ENV['SN_USER'] }
  c.filter_sensitive_data('<SN_PASSWORD>') { ENV['SN_PASSWORD'] }
  c.before_record do |i|
    i.response.body.force_encoding 'UTF-8'
    i.request.headers.delete('Authorization')
    i.response.headers.delete('Set-Cookie')
  end
end
