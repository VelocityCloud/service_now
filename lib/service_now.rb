require "service_now/table"
require "service_now/identify"
require "service_now/version"

module ServiceNow
  def self.const_missing(name)
    const_set name, Class.new(Table)
  end
end
