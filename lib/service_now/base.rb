require 'httparty'

module ServiceNow
  class Base
    include HTTParty
    headers 'Accept' => 'application/json'

    def self.find(sys_id, auth)
      get("#{url(auth)}/api/now/table/#{table_name}/#{sys_id}", basic_auth: { username: auth[:user], password: auth[:password] })['result']
    end

    def self.url(auth)
      "https://#{auth[:host]}"
    end

    def self.table_name
      to_s.downcase.split('::').last
    end
  end
end
