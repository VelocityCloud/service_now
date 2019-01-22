require 'httparty'

module ServiceNow
  class Table
    include HTTParty
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'

    class << self
      def all(params = {}, auth)
        exec :get, "?#{build_query(params)}", {}, auth
      end

      def find(sys_id, auth)
        exec :get, "/#{sys_id}", {}, auth
      end

      def create(params, auth)
        exec :post, "", params, auth
      end

      def update(sys_id, params, auth)
        exec :patch, "/#{sys_id}", params, auth
      end

      private

      def url(auth)
        "https://#{auth[:host]}/api/now/table/#{table_name}"
      end

      def table_name
        to_s.split('::').last.gsub(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
      end

      def exec(method, path, params, auth)
        send(method, "#{url(auth)}#{path}", body: params.to_json, basic_auth: { username: auth[:user], password: auth[:password] })
      end

      def build_query(params)
        params.to_a.map { |name, value| "#{name}=#{value}" }.join('&')
      end
    end
  end
end
