require 'httparty'

module ServiceNow
  class Base
    include HTTParty
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'

    def self.all(params = {}, auth)
      exec :get, "?#{build_query(params)}", {}, auth
    end

    def self.find(sys_id, auth)
      exec :get, "/#{sys_id}", {}, auth
    end

    def self.create(params, auth)
      exec :post, "", params, auth
    end

    def self.url(auth)
      "https://#{auth[:host]}/api/now/table/#{table_name}"
    end

    def self.table_name
      to_s.downcase.split('::').last
    end

    def self.exec(method, path, params, auth)
      send(method, "#{url(auth)}#{path}", body: params.to_json, basic_auth: { username: auth[:user], password: auth[:password] })['result']
    end

    def self.build_query(params)
      params.to_a.map { |name, value| "#{name}=#{value}" }.join('&')
    end
  end
end
