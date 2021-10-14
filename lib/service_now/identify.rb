# frozen_string_literal: true

module ServiceNow
  class Identify < Table
    class << self
      def reconcile_enhanced(params, body, auth)
        exec :post, "reconcile/enhanced?#{build_query(params)}", body, auth
      end

      private

      def url(auth)
        "https://#{auth[:host]}/api/now/identify"
      end
    end
  end
end
